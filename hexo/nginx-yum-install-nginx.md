---
title: 'nginx# yum 安装最新稳定版nginx'
date: 2016-03-14 11:25:38
categories: nginx
toc: true
tags:
---

`nginx 官方文档：http://nginx.org/en/linux_packages.html`

##### To set up the yum repository for RHEL/CentOS, create the file named /etc/yum.repos.d/nginx.repo with the following contents:

```
					[nginx]
					name=nginx repo
					baseurl=http://nginx.org/packages/OS/OSRELEASE/$basearch/
					gpgcheck=0
					enabled=1
```
######    	Replace "OS" with "rhel" or "centos", depending on the distribution used, and "OSRELEASE" with "5", "6", or "7", for 5.x, 6.x, or 7.x versions, respectively。
  
    
#####    install nginx
        
```
					yum -y install nginx
```
###### Configure arguments common for nginx binaries from pre-built packages for stable version:

```
					--prefix=/etc/nginx
					--sbin-path=/usr/sbin/nginx
					--conf-path=/etc/nginx/nginx.conf
					--error-log-path=/var/log/nginx/error.log
					--http-log-path=/var/log/nginx/access.log
					--pid-path=/var/run/nginx.pid
					--lock-path=/var/run/nginx.lock
					--http-client-body-temp-path=/var/cache/nginx/client_temp
					--http-proxy-temp-path=/var/cache/nginx/proxy_temp
					--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp
					--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp
					--http-scgi-temp-path=/var/cache/nginx/scgi_temp
					--user=nginx
					--group=nginx
					--with-http_ssl_module
					--with-http_realip_module
					--with-http_addition_module
					--with-http_sub_module
					--with-http_dav_module
					--with-http_flv_module
					--with-http_mp4_module
					--with-http_gunzip_module
					--with-http_gzip_static_module
					--with-http_random_index_module
					--with-http_secure_link_module
					--with-http_stub_status_module
					--with-http_auth_request_module
					--with-mail
					--with-mail_ssl_module
					--with-file-aio
					--with-http_spdy_module
					--with-ipv6
```

###### Packages for mainline version also have the following arguments:
```
					--with-threads
					--with-stream
					--with-stream_ssl_module
					--with-http_slice_module
```
###### and
```
					--with-http_spdy_module
```

###### replaced with
```
					--with-http_v2_module
```
###### Package are built with all modules that do not require additional libraries to avoid extra dependencies.