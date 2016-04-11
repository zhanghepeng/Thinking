---
title: 'zabbix# centos7 yum安装zabbix3'
date: 2016-03-14 11:25:38
categories: zabbix
toc: true
tags:
---

##### 安装epel源,并安装所需要的软件
```
			rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm 
			yum -y install gcc gcc-c++ vim openipmi libssh2 fping libcurl libiksemel libxml2 net-snmp		
```

##### 防火墙设置 firewall-cmd
`
			启用防火墙: systemctl start firewalld.service
			查看状态：    systemctl start firewalld.service  /  firewall-cmd --state
			开机启动：  systemctl enable firewalld.service
			添加永久端口：  firewall-cmd --permanet  --add-port=10050/tcp
			删除永久端口:    firewall-cmd --permanent --remove-port=80/tcp
			配置生效：  firewall-cmd --reload
`
```							
			[root@monitor opt]# firewall-cmd --state
			running
			[root@monitor opt]# firewall-cmd --list-all
			public (default)
			  interfaces: 
			  sources: 
			  services: dhcpv6-client ssh
			  ports: 10050/tcp
			  masquerade: no
			  forward-ports: 
			  icmp-blocks: 
			  rich rules: 
				
			[root@monitor opt]# firewall-cmd --permanent --add-port=80/tcp
			success
			[root@monitor opt]# firewall-cmd --reload
			success
			[root@monitor opt]# firewall-cmd --list-all
			public (default)
			  interfaces: 
			  sources: 
			  services: dhcpv6-client ssh
			  ports: 80/tcp 10050/tcp
			  masquerade: no
			  forward-ports: 
			  icmp-blocks: 
			  rich rules: 
			[root@monitor ~]# firewall-cmd --permanent --remove-port=80/tcp
			success
			[root@monitor ~]# firewall-cmd --reload                        
			success
			[root@monitor ~]# firewall-cmd --list-all
			public (default)
			  interfaces: 
			  sources: 
			  services: dhcpv6-client ssh
			  ports: 10050/tcp
			  masquerade: no
			  forward-ports: 
			  icmp-blocks: 
			  rich rules: 
```
##### 安装 php56
```
        	rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
        	
        	yum -y install  php56w php56w-gd php56w-bcmath php56w-ctype php56w-fpm php56w-xml php56w-dom php56w-xmlreader php56w-xmlwriter php56w-session php56w-net-socket php56w-mbstring php56w-gettext php56w-mysqlnd 
       
        	#修改/etc/php.ini 部参数的值
        	 max_execution_time 300
        	 memory_limit 128M
        	 post_max_size 16M
        	 upload_max_filesize 2M
        	 max_input_time 300
        	 always_populate_raw_post_data -1
        	 date.timezone "Asia/Shanghai"	
        	
        	#启动 php-fpm 
        		systemctl start php-fpm.service
```
##### 安装nginx
```
	cat  /etc/yum.repos.d/nginx.repo 
		[nginx]
		name=nginx repo
		baseurl=http://nginx.org/packages/centos/7/$basearch/
		gpgcheck=0
		enabled=1
	yum -y install nginx gperftools 
```
	
##### 安装mysql数据库 percona-server 
```
		yum -y install http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm
		yum  -y install Percona-Server-server-57
```
##### 安装 zabbix3.0
```
			rpm -ivh http://repo.zabbix.com/zabbix/3.0/rhel/7/x86_64/zabbix-release-3.0-1.el7.noarch.rpm
			#安装zabbix server
			yum install zabbix-server-mysql zabbix-web-mysql -y 
			#安装zabbix agent
			yum install zabbix-agent -y
			#初始化zabbix 数据库
			[root@localhost doc]# mysql -e "CREATE DATABASE IF NOT EXISTS zabbix DEFAULT CHARSET utf8 COLLATE utf8_general_ci;"
			[root@localhost doc]# cd /usr/share/doc/zabbix-server-mysql-3.0.0/
			[root@localhost zabbix-server-mysql-3.0.0]# ls
			AUTHORS  ChangeLog  COPYING  create.sql.gz  NEWS  README
			[root@localhost doc]# zcat create.sql.gz | mysql -uroot zabbix
```
##### 配置zabbix server连接数据库
```
	[root@localhost zabbix]# cat /etc/zabbix/zabbix_server.conf |grep -E 'DB(N|P|H)'
	### Option: DBHost
	 DBHost=192.168.0.44
	### Option: DBName
	#	For SQLite3 path to database file must be provided. DBUser and DBPassword are ignored.
	# DBName=
	DBName=zabbix
	### Option: DBPassword
	# DBPassword=
	 DBPassword=zabbixpassword
	### Option: DBPort
	# DBPort=3306
```
##### 配置nginx,使用nginx来代理zabbix,并打开nginx status,和php-fpm 状态页
```
	[root@localhost zabbix]# cat  /etc/nginx/conf.d/zabbix.conf 
        server {
            listen       80;
            server_name  localhost;

            charset utf8;
            access_log  /var/log/nginx/zabbix.access.log  main;

            location / {
                root   /usr/share/zabbix;
                index   index.php index.html index.htm;
            }

            #error_page  404              /404.html;

            # redirect server error pages to the static page /50x.html
            #
            error_page   500 502 503 504  /50x.html;
            location = /50x.html {
                root   /usr/share/nginx/html;
            }

            # proxy the PHP scripts to Apache listening on 127.0.0.1:80
            #
            #location ~ \.php$ {
            #    proxy_pass   http://127.0.0.1;
            #}

            # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
            #
        ################# nginx status #################################
        location =/nginx_status/ {
                # Turn on nginx stats
                stub_status on;
                # I do not need logs for stats
                access_log   off;
                # Security: Only allow access from IP #
                allow 127.0.0.1;
            deny all;
            }

        ################# nginx status  end #################################
        ################# php-fpm status  end #################################
        location = /php-fpm_status
            {
                include fastcgi_params;
                fastcgi_pass 127.0.0.1:9000;
                fastcgi_param SCRIPT_FILENAME $fastcgi_script_name;
            }

        ################# php-fpm status  end #################################
            location ~ \.php$ {
                root           /usr/share/zabbix;
                fastcgi_pass   127.0.0.1:9000;
                fastcgi_index  index.php;
                fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
                include        fastcgi_params;
            }

            # deny access to .htaccess files, if Apache's document root
            # concurs with nginx's one
            #
            #location ~ /\.ht {
            #    deny  all;
            #}
        }
```
##### 重启systemctl restart nginx.service