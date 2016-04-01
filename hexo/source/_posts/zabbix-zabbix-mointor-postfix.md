---
title: 'zabbix# zabbix3.0 监控 postfix'
date: 2016-03-14 11:25:38
categories: zabbix
toc: true
tags:
---


##### 1,安装两个软件 pflogsumm & logtail
```
	 pflogsumm:  #网址：http://jimsun.linxnet.com/postfix_contrib.html  
				 #下载：http://jimsun.linxnet.com/downloads/pflogsumm-1.1.3.tar.gz


						[root@mail opt]# tar -xf pflogsumm-1.1.3.tar.gz 
						[root@mail opt]# cd pflogsumm-1.1.3
						[root@mail pflogsumm-1.1.3]# ls
						ChangeLog  pflogsumm.1  pflogsumm-faq.txt  pflogsumm.pl  README  ToDo
						[root@mail pflogsumm-1.1.3]# mv pflogsumm.pl  /usr/sbin/pflogsumm 
					
	 logtail: #网址:http://www.fourmilab.ch/webtools/logtail/
			  #下载：http://www.fourmilab.ch/webtools/logtail/logtail.tar.gz

					[root@mail opt]# tar -zxf logtail.tar.gz 
					[root@mail opt]# ls
					logstash  logtail.1  logtail.gif  logtail.html  logtail.pl  logtail.tar.gz  pflogsumm-1.1.3  pflogsumm-1.1.3.tar.gz
					[root@mail opt]# chmod +x logtail.pl 
					[root@mail opt]# mv logtail.pl  logtail
					[root@mail opt]# which perl
					/usr/bin/perl
					[root@mail opt]# head -1 logtail
					#! /bin/perl
					[root@mail opt]# sed -i s"/bin\/perl/usr\/bin\/perl/g" logtail
					[root@mail opt]# head -1 logtail
					#! /usr/bin/perl
					[root@mail opt]# mb logtail /usr/sbin/logtail
```
##### 2,创建 监控 postfix 参数文件
```
				[root@mail opt]# cat /etc/zabbix/zabbix_agentd.d/postfix.conf 
				UserParameter=postfix.pfmailq,mailq | grep -v "Mail queue is empty" | grep -c '^[0-9A-Z]'
				UserParameter=postfix[*],/etc/zabbix/scripts/postfix-zabbix-stats.sh $1
```
##### 3,创建脚本在 第三步中 想对应的位置(位置可以不同，但是必须对应)
```
			vim /etc/zabbix/scripts/postfix-zabbix-stats.sh
				#!/usr/bin/env bash
				MAILLOG=/var/log/maillog
				PFOFFSETFILE=/tmp/zabbix-postfix-offset.dat
				PFSTATSFILE=/tmp/postfix_statsfile.dat
				TEMPFILE=$(mktemp)
				PFLOGSUMM=/usr/sbin/pflogsumm
				LOGTAIL=/usr/sbin/logtail

				PFVALS=( 'received' 'delivered' 'forwarded' 'deferred' 'bounced' 'rejected' 'held' 'discarded' 'reject_warnings' 'bytes_received' 'bytes_delivered' )

				[ ! -e "${PFSTATSFILE}" ] && touch "${PFSTATSFILE}" && chown zabbix:zabbix "${PFSTATSFILE}"

				printvalues() {
				  key=$1
				  pfkey=$(echo "$1" | tr '_' ' ')
				  value=$(grep -m 1 "${pfkey}" $TEMPFILE | awk '{print $1}' | awk '/k|m/{p = /k/?1:2}{printf "%d\n", int($1) * 1024 ^ p}')
				  old_value=$(grep -e "^${key};" "${PFSTATSFILE}" | cut -d ";" -f2)
				  if [ -n "${old_value}" ]; then
					sed -i -e "s/^${key};${old_value}/${key};$((${old_value}+${value}))/" "${PFSTATSFILE}"
				  else
					echo "${key};${value}" >> "${PFSTATSFILE}"
				  fi
				}

				if [ -n "$1" ]; then 
				  key=$(echo ${PFVALS[@]} | grep -wo $1)
				  if [ -n "${key}" ]; then
					value=$(grep -e "^${key};" "${PFSTATSFILE}" | cut -d ";" -f2)
					echo "${value}"
				  else
					rm "${TEMPFILE}"
					exit 2
				  fi
				else
				  "${LOGTAIL}" -f"${MAILLOG}" -o"${PFOFFSETFILE}" | "${PFLOGSUMM}" -h 0 -u 0 --bounce_detail=0 --deferral_detail=0 --reject_detail=0 --no_no_msg_size --smtpd_warning_detail=0 > "${TEMPFILE}"
				  for i in "${PFVALS[@]}"; do
					printvalues "$i"
				  done
				fi

				rm "${TEMPFILE}"
	
```
##### 4,添加crontab 任务
```
		*/5 * * * * /etc/zabbix/scripts/postfix-zabbix-stats.sh
```
##### 5,在 zabbix server 端添加模版 (模版见github)
```
   cat zabbix postfix template.xml
```
   
