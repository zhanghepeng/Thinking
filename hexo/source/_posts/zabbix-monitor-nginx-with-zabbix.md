---
title: 'zabbix# zabbix3.0 监控 nginx'
date: 2016-03-14 11:25:38
categories: zabbix
toc: true
tags:
---

```
	zabbix 监控 nginx 使用的是监控nginx的状态页,步骤分为如下几步:
			1,开启nginx 状态页
			2,编写nginx 监控脚本
			3,配置nginx 的参数文件
			4,导入nginx 模版
```


##### 1,配置nginx,打开nginx 状态模块,监控是要注意nginx 配置的url 和 host 要跟第二步相对应

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
##### 2,把监控nginx的脚本放到 zabbix agent 的相应目录



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

#####  3,编写 监控 nginx 的参数文件,放到指定位置

```
			[root@localhost scripts]# cat /etc/zabbix/zabbix_agentd.d/zabbix_nginx.conf 
			UserParameter=check_nginx[*],/etc/zabbix/scripts/check_nginx.sh "$1"
```
#####  4,导入模版(模版见github:https://github.com/zhanghepeng/Thinking.git)
		
