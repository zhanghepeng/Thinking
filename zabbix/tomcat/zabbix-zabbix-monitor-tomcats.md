---
title: 'zabbix# zabbix3.0 ��� tomcat'
date: 2016-03-14 11:25:38
categories: zabbix
toc: true
tags:
---

`zabbix ���tomcats,ʵ�����������ǻ��õ�һ̨�������tomcat,��ͬ�Ķ˿�,����Ҳ�������һЩ��tomcat�ļ��.
	zabbix���Դ�jvmģ�������tomcat,����������ʹ�ýű���ض��tomcatʵ��,���ýű�����ȡtomcat�ļ��ҳ����Ϣ;
	 ���tomcat��˿ڲ���ɷ�Ϊ���¼���:
			1,����tomcat�ļ��ҳ,������tomcat���ҳ���ʺ�����`
			2,����tomcat�������Ҫ�������ļ�,�����ļ���Ϊ3��:2���ű�,һ����¼�˿ڵ��ı�
			3,��д���tomcat�Ĳ���
			4,����tomcatģ��`
			

#####  1,����tomcat�ļ��ҳ,������tomcat���ҳ���ʺ�����

```
		#tomcat Ĭ�ϼ��ҳ�Ĵ����Ƿ���webapps�µ�,������tomcat��ص��ʺ����뼴�ɷ���,ǰ���Ǳ�֤���õ��������Է�
			�ʵ�tomcat��ش���,����Ĭ��ʹ�õ����Զ���tomcat ��������֤��������ҵ���������ͻ,��Ȼ�ڼ������Ҫ����һ����
				����host���ɣ����˵�tomcat�ļ�����:
				1,tomcat ״̬��������ļ�:
						#cat conf/server.xml
						..........
						<!--######################### start  ����������� ����ɾ�� ################################# -->
							<Host name="188.monitor"  appBase="webapps"
									unpackWARs="true" autoDeploy="true">
								<Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
									prefix="monitor.log" suffix=".log"
									pattern="%h %l %u %t &quot;%r&quot; %s %b" />
							</Host>
						<!--######################### end  ����������� ����ɾ�� ################################# -->
				2,����tomcat����ʺ�����(tomcatuser Ϊ�Լ����û�,tomcatpassword Ϊ�Լ���tomcat����):
						#cat conf/tomcat-user.xml
						..........
						<user username="tomcatuser" password="tomcatpassword" roles="manager-gui"/>
						</tomcat-users>
	
```

#####  2,����tomcat�������Ҫ�������ļ�

```
					# ls /etc/zabbix/scripts/
					  check_tomcat.sh    Tomcat_Discovery_Ports.py  Tomcat_Ports
					#�����ļ�����:
						1,Tomcat_Ports:tomcat�˿������ļ�(�ж��ٸ�tomcat���� <tomcat �˿�>�����ڵ���ʽд�����ļ�����);
						2,check_tomcat.sh:���tomcatҳ��״̬��Ϣ
						3,Tomcat_Discovery_Ports.py:��json�ĸ�ʽ��ʾ��tomcat�Ķ˿�
						
					#�����ű�����Ч������:
							[root@web1 scripts]# cat Tomcat_Ports 
							tomcat 8000
							tomcat 8010
							tomcat 8020
							tomcat 8030
							tomcat 8040
							tomcat 8050
							tomcat 8060
							[root@web1 scripts]# ./Tomcat_Discovery_Ports.py 
							{
								"data":[
									{
										"{#TOMCATPORTS}":"8000"
									},
									{
										"{#TOMCATPORTS}":"8010"
									},
									{
										"{#TOMCATPORTS}":"8020"
									},
									{
										"{#TOMCATPORTS}":"8030"
									},
									{
										"{#TOMCATPORTS}":"8040"
									},
									{
										"{#TOMCATPORTS}":"8050"
									},
									{
										"{#TOMCATPORTS}":"8060"
									}
								]
							}
							# ./check_tomcat.sh Max_threads 8030
							200

```

##### 3,��д���tomcat�Ĳ���(�˴��Ĳ����ļ���Ҫִ�еڶ�����tomcat�ű�,�ű�����Ҫ��Ӧ)

```
					# cat /etc/zabbix/zabbix_agentd.d/zabbix_tomcat.conf 
					UserParameter=Tomcat.Ports.discovery,/etc/zabbix/scripts/Tomcat_Discovery_Ports.py
					UserParameter=TomcatCheckers[*],/etc/zabbix/scripts/check_tomcat.sh $1 $2

```

##### 4,����tomcatģ��
```
				tomcat ģ���github
```