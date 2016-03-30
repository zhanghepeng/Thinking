---
title: 'zabbix# zabbix3.0 监控 tomcat'
date: 2016-03-14 11:25:38
categories: zabbix
toc: true
tags:
---

`zabbix 监控tomcats,实际生产中我们会用到一台机器多个tomcat,不同的端口,所有也就许多做一些对tomcat的监控.
	zabbix有自带jvm模版来监控tomcat,这里我们来使用脚本监控多个tomcat实例,利用脚本来获取tomcat的监控页的信息;
	 监控tomcat多端口步骤可分为如下几个:
			1,开启tomcat的监控页,并配置tomcat监控页的帐号密码`
			2,创建tomcat监控所需要的配置文件,配置文件分为3个:2个脚本,一个记录端口的文本
			3,编写监控tomcat的参数
			4,导入tomcat模版`
			

#####  1,开启tomcat的监控页,并配置tomcat监控页的帐号密码

```
		#tomcat 默认监控页的代码是放在webapps下的,配置下tomcat监控的帐号密码即可访问,前提是保证配置的域名可以访
			问到tomcat监控代码,个人默认使用的是自定义tomcat 域名，保证不与其他业务的域名冲突,当然在监控是需要配置一下主
				机的host即可，本人的tomcat文件如下:
				1,tomcat 状态监控配置文件:
						#cat conf/server.xml
						..........
						<!--######################### start  监控配置区域 不能删除 ################################# -->
							<Host name="188.monitor"  appBase="webapps"
									unpackWARs="true" autoDeploy="true">
								<Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
									prefix="monitor.log" suffix=".log"
									pattern="%h %l %u %t &quot;%r&quot; %s %b" />
							</Host>
						<!--######################### end  监控配置区域 不能删除 ################################# -->
				2,配置tomcat监控帐号密码(tomcatuser 为自己的用户,tomcatpassword 为自己的tomcat密码):
						#cat conf/tomcat-user.xml
						..........
						<user username="tomcatuser" password="tomcatpassword" roles="manager-gui"/>
						</tomcat-users>
	
```

#####  2,创建tomcat监控所需要的配置文件

```
					# ls /etc/zabbix/scripts/
					  check_tomcat.sh    Tomcat_Discovery_Ports.py  Tomcat_Ports
					#三个文件功能:
						1,Tomcat_Ports:tomcat端口配置文件(有多少个tomcat就以 <tomcat 端口>括号内的形式写到此文件里面);
						2,check_tomcat.sh:检测tomcat页的状态信息
						3,Tomcat_Discovery_Ports.py:以json的格式显示出tomcat的端口
						
					#各个脚本运行效果如下:
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

##### 3,编写监控tomcat的参数(此处的参数文件是要执行第二步的tomcat脚本,脚本名称要对应)

```
					# cat /etc/zabbix/zabbix_agentd.d/zabbix_tomcat.conf 
					UserParameter=Tomcat.Ports.discovery,/etc/zabbix/scripts/Tomcat_Discovery_Ports.py
					UserParameter=TomcatCheckers[*],/etc/zabbix/scripts/check_tomcat.sh $1 $2

```

##### 4,导入tomcat模版
```
				tomcat 模版见github
```