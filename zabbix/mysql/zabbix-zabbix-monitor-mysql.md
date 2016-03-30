---
title: 'zabbix# zabbix3.0 监控 mysql'
date: 2016-03-14 11:25:38
categories: zabbix
toc: true
tags:
---

`使用zabbix 监控 mysql  (使用Percona Monitoring Plugins for Zabbix 插件监控mysql，此插件是php 和shell 语言配合来监控的，所以需要php命令,
	可以使用yum -y install php php-mysqli ,插件官网：https://www.percona.com/software/mysql-tools/percona-monitoring-plugins)`

		
##### 安装插件源
```
		yum -y install http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm 
```
		
##### 安装插件

```
		yum install percona-zabbix-templates -y
	#安装后的文件路径:
		[root@monitor nginx]# rpm -ql percona-zabbix-templates
		/var/lib/zabbix/percona
		/var/lib/zabbix/percona/scripts
		/var/lib/zabbix/percona/scripts/get_mysql_stats_wrapper.sh
		/var/lib/zabbix/percona/scripts/ss_get_mysql_stats.php
		/var/lib/zabbix/percona/templates
		/var/lib/zabbix/percona/templates/userparameter_percona_mysql.conf
		/var/lib/zabbix/percona/templates/zabbix_agent_template_percona_mysql_server_ht_2.0.9-sver1.1.6.xml
```
##### 创建zabbix agent 的参数文件
```
		mkdir mkdir /etc/zabbix/scripts -p
		cp /var/lib/zabbix/percona/templates/userparameter_percona_mysql.conf /etc/zabbix/zabbix_agentd.d/   #复制到的路径要和zabbix_agentd.conf 配置的路径相对应(见第4步)
```
##### 配置zabbix agent 配置文件

```
		cat /etc/zabbix/zabbix_agentd.conf |grep Include
			##### Option: Include
			# Include=
			Include=/etc/zabbix/zabbix_agentd.d/		# 此项要打开，如果此处的文件路径可以更改，但是必须和第三步的文件路径相对应
			# Include=/usr/local/etc/zabbix_agentd.userparams.conf
			# Include=/usr/local/etc/zabbix_agentd.conf.d/
			# Include=/usr/local/etc/zabbix_agentd.conf.d/*.conf
```
##### 配置mysql 的连接
```
		 #更改php脚本连接数据库的帐号和密码
		 [root@monitor zabbix]# cat /var/lib/zabbix/percona/scripts/ss_get_mysql_stats.php|grep  -E '\$mysql_user =|\$mysql_pass ='
			$mysql_user = 'cactiuser';     #cactiuser 改为自己连接数据库的帐号
			$mysql_pass = 'cactiuser';	   #cactiuser 改为自己连接数据库的密码
```
##### 测试脚本连接数据库状况,测试能否获取数据

```
			[root@monitor scripts]# /var/lib/zabbix/percona/scripts/get_mysql_stats_wrapper.sh gg
				0     #有数据的话就证明可以使用
			[root@monitor ~]# php -q /var/lib/zabbix/percona/scripts/ss_get_mysql_stats.php --host localhost --items gg
			gg:11752[root@monitor ~]#
```
##### 创建密码文件

```
					[root@monitor scripts]# cat  ~zabbix/.my.cnf
					[client]
					user = root
					password = 
```					
##### 重启 zabbix agent；

```
		systemctl restart zabbix-agent.service
		#重启之后看zabbix server 的日志，有时候需要删除 /tmp 下的 rm -rf localhost-mysql_cacti_stats.txt 文件，这个文件会自动生成
```
		9,把 zabbix agent 端的模版文件导入到 zabbix server 端
```
		/var/lib/zabbix/percona/templates/zabbix_agent_template_percona_mysql_server_ht_2.0.9-sver1.1.6.xml
```		


			