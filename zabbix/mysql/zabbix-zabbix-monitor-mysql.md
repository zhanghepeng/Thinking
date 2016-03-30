---
title: 'zabbix# zabbix3.0 ��� mysql'
date: 2016-03-14 11:25:38
categories: zabbix
toc: true
tags:
---

`ʹ��zabbix ��� mysql  (ʹ��Percona Monitoring Plugins for Zabbix ������mysql���˲����php ��shell �����������صģ�������Ҫphp����,
	����ʹ��yum -y install php php-mysqli ,���������https://www.percona.com/software/mysql-tools/percona-monitoring-plugins)`

		
##### ��װ���Դ
```
		yum -y install http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm 
```
		
##### ��װ���

```
		yum install percona-zabbix-templates -y
	#��װ����ļ�·��:
		[root@monitor nginx]# rpm -ql percona-zabbix-templates
		/var/lib/zabbix/percona
		/var/lib/zabbix/percona/scripts
		/var/lib/zabbix/percona/scripts/get_mysql_stats_wrapper.sh
		/var/lib/zabbix/percona/scripts/ss_get_mysql_stats.php
		/var/lib/zabbix/percona/templates
		/var/lib/zabbix/percona/templates/userparameter_percona_mysql.conf
		/var/lib/zabbix/percona/templates/zabbix_agent_template_percona_mysql_server_ht_2.0.9-sver1.1.6.xml
```
##### ����zabbix agent �Ĳ����ļ�
```
		mkdir mkdir /etc/zabbix/scripts -p
		cp /var/lib/zabbix/percona/templates/userparameter_percona_mysql.conf /etc/zabbix/zabbix_agentd.d/   #���Ƶ���·��Ҫ��zabbix_agentd.conf ���õ�·�����Ӧ(����4��)
```
##### ����zabbix agent �����ļ�

```
		cat /etc/zabbix/zabbix_agentd.conf |grep Include
			##### Option: Include
			# Include=
			Include=/etc/zabbix/zabbix_agentd.d/		# ����Ҫ�򿪣�����˴����ļ�·�����Ը��ģ����Ǳ���͵��������ļ�·�����Ӧ
			# Include=/usr/local/etc/zabbix_agentd.userparams.conf
			# Include=/usr/local/etc/zabbix_agentd.conf.d/
			# Include=/usr/local/etc/zabbix_agentd.conf.d/*.conf
```
##### ����mysql ������
```
		 #����php�ű��������ݿ���ʺź�����
		 [root@monitor zabbix]# cat /var/lib/zabbix/percona/scripts/ss_get_mysql_stats.php|grep  -E '\$mysql_user =|\$mysql_pass ='
			$mysql_user = 'cactiuser';     #cactiuser ��Ϊ�Լ��������ݿ���ʺ�
			$mysql_pass = 'cactiuser';	   #cactiuser ��Ϊ�Լ��������ݿ������
```
##### ���Խű��������ݿ�״��,�����ܷ��ȡ����

```
			[root@monitor scripts]# /var/lib/zabbix/percona/scripts/get_mysql_stats_wrapper.sh gg
				0     #�����ݵĻ���֤������ʹ��
			[root@monitor ~]# php -q /var/lib/zabbix/percona/scripts/ss_get_mysql_stats.php --host localhost --items gg
			gg:11752[root@monitor ~]#
```
##### ���������ļ�

```
					[root@monitor scripts]# cat  ~zabbix/.my.cnf
					[client]
					user = root
					password = 
```					
##### ���� zabbix agent��

```
		systemctl restart zabbix-agent.service
		#����֮��zabbix server ����־����ʱ����Ҫɾ�� /tmp �µ� rm -rf localhost-mysql_cacti_stats.txt �ļ�������ļ����Զ�����
```
		9,�� zabbix agent �˵�ģ���ļ����뵽 zabbix server ��
```
		/var/lib/zabbix/percona/templates/zabbix_agent_template_percona_mysql_server_ht_2.0.9-sver1.1.6.xml
```		


			