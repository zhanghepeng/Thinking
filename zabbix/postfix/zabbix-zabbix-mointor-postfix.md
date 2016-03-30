---
title: 'zabbix# zabbix3.0 ��� postfix'
date: 2016-03-14 11:25:38
categories: zabbix
toc: true
tags:
---


##### 1,��װ������� pflogsumm & logtail
	
	 pflogsumm:  ��ַ��http://jimsun.linxnet.com/postfix_contrib.html  
				���أ�http://jimsun.linxnet.com/downloads/pflogsumm-1.1.3.tar.gz

				 ��װ��
```
						[root@mail opt]# tar -xf pflogsumm-1.1.3.tar.gz 
						[root@mail opt]# cd pflogsumm-1.1.3
						[root@mail pflogsumm-1.1.3]# ls
						ChangeLog  pflogsumm.1  pflogsumm-faq.txt  pflogsumm.pl  README  ToDo
						[root@mail pflogsumm-1.1.3]# mv pflogsumm.pl  /usr/sbin/pflogsumm 
```						
	 logtail: ��ַ:http://www.fourmilab.ch/webtools/logtail/
			 ���أ�http://www.fourmilab.ch/webtools/logtail/logtail.tar.gz
			 ��װ��
```
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
##### 2,���� ��� postfix �����ļ�
```
				[root@mail opt]# cat /etc/zabbix/zabbix_agentd.d/postfix.conf 
				UserParameter=postfix.pfmailq,mailq | grep -v "Mail queue is empty" | grep -c '^[0-9A-Z]'
				UserParameter=postfix[*],/etc/zabbix/scripts/postfix-zabbix-stats.sh $1
```
##### 3,�����ű��� �������� ���Ӧ��λ��(λ�ÿ��Բ�ͬ�����Ǳ����Ӧ)
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
##### 4,���crontab ����
```
		*/5 * * * * /etc/zabbix/scripts/postfix-zabbix-stats.sh
```		
##### 5,�� zabbix server �����ģ�� (ģ���github)
   cat zabbix postfix template.xml
   
