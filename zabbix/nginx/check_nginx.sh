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
