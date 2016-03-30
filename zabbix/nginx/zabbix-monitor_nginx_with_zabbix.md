---
title: 'zabbix# zabbix3.0 ��� nginx'
date: 2016-03-14 11:25:38
categories: zabbix
toc: true
tags:
---

```
	zabbix ��� nginx ʹ�õ��Ǽ��nginx��״̬ҳ,�����Ϊ���¼���:
			1,����nginx ״̬ҳ
			2,��дnginx ��ؽű�
			3,����nginx �Ĳ����ļ�
			4,����nginx ģ��
```


##### 1,����nginx,��nginx ״̬ģ��,�����Ҫע��nginx ���õ�url �� host Ҫ���ڶ������Ӧ

```
			location =/nginx_status/ {
				# Turn on nginx stats
				stub_status on;
				# I do not need logs for stats
				access_log   off;
				# Security: Only allow access from IP #
				allow 127.0.0.1;
			deny all;
			}
```
##### 2,�Ѽ��nginx�Ľű��ŵ� zabbix agent ����ӦĿ¼



```
		[root@localhost scripts]# cat /etc/zabbix/scripts/check_nginx.sh 
				#!/bin/bash

				#"use: sh check_nginx.sh  [Active|accepts|handled|requests|Reading|Writing|Waiting|status_code|status_pid]"

				host=127.0.0.1
				port=80
				url=/nginx_status/
				checkers=(Active accepted handled request Reading Writting Waiting)

				function Active {
					curl http://${host}:${port}${url} 2>/dev/null |grep Active|awk '{print $3}'

				} 
				function Reading {
					curl http://${host}:${port}${url} 2>/dev/null |grep Reading| awk '{print $2}'

				}
				function Writing {
					curl http://${host}:${port}${url} 2>/dev/null |grep Writing| awk '{print $4}'
				}
				function Waiting {
					curl http://${host}:${port}${url} 2>/dev/null |grep Waiting| awk '{print $6}'
				}
				function accepts {
					curl http://${host}:${port}${url} 2>/dev/null |awk NR==3|awk '{print $1}'
				}
				function handled {
					curl http://${host}:${port}${url} 2>/dev/null |awk NR==3|awk '{print $2}'
				}
				function requests {
					curl http://${host}:${port}${url} 2>/dev/null |awk NR==3|awk '{print $3}'
				}
				function status_code {
					curl -o /dev/null -s -w %{http_code} http://${host}:${port}${url}
				}
				function status_pid {
					pidof nginx|wc -w
				}
				$1

```

#####  3,��д ��� nginx �Ĳ����ļ�,�ŵ�ָ��λ��

```
			[root@localhost scripts]# cat /etc/zabbix/zabbix_agentd.d/zabbix_nginx.conf 
			UserParameter=check_nginx[*],/etc/zabbix/scripts/check_nginx.sh "$1"
```
#####  4,����ģ��(ģ���github:https://github.com/zhanghepeng/Thinking.git)
		
