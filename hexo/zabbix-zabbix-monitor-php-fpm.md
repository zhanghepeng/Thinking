---
title: 'zabbix# zabbix3.0 ��� php-fpm'
date: 2016-04-12 11:25:38
categories: zabbix
toc: true
tags:
---

1,����php-fpm״̬ҳ
2,����nginx����php-fpm״̬ҳ
3,curl����php-fpm״̬�ķ��� 

##### 1,php-fpm״̬ҳ
```
	sed -i s",;pm.status_path = /status,pm.status_path = /php-fpm_status,g" /etc/php-fpm.d/www.conf
	systemctl restart php-fpm.service
	systemctl enable php-fpm.service
```

##### 2,����nginx����php-fpm״̬ҳ
```
......
		################# php-fpm status  end #################################
        location = /php-fpm_status
           {
               include fastcgi_params;
               fastcgi_pass 127.0.0.1:9000;
               fastcgi_param SCRIPT_FILENAME $fastcgi_script_name;
           }

        ################# php-fpm status  end #################################
......

	 reloadʹnginx��Ч��
		nginx -s reload
```
##### 3,curl����php-fpm״̬�ķ���
```
		[root@localhost php-fpm.d]# curl http://localhost/php-fpm_status
		pool:                 www
		process manager:      dynamic
		start time:           13/Apr/2016:05:28:42 +0800
		start since:          397
		accepted conn:        51
		listen queue:         0
		max listen queue:     0
		listen queue len:     128
		idle processes:       5
		active processes:     1
		total processes:      6
		max active processes: 2
		max children reached: 0
		slow requests:        0
```
