#!/bin/bash
#auth zhanghepng
#2016-04-12
#通过php-fpm的状态页来获取php-fpm的状态

#
#php-fpm url
url_php=http://localhost/php-fpm_status
case $1 in

pool)
	 curl   -O /dev/null -s  ${url_php}|grep "pool" |awk  -F ':' '{print$2}'|awk '{print$1}'
	;;
process_manager)
	 curl   -O /dev/null -s  ${url_php}|grep "process manager" |awk  -F ':' '{print$2}'|awk '{print$1}'
	;;
start_time)
	 curl   -O /dev/null -s  ${url_php}|grep "start time" |awk  -F ':' '{print$2}'|awk '{print$1}'
	;;
start_since)
	 curl   -O /dev/null -s  ${url_php}|grep "start since" |awk  -F ':' '{print$2}'|awk '{print$1}'
	;;
accepted_conn)
	 curl   -O /dev/null -s  ${url_php}|grep "accepted conn" |awk  -F ':' '{print$2}'|awk '{print$1}'
	;;
listen_queue)
	 curl   -O /dev/null -s  ${url_php}|grep "listen queue" |awk  -F ':' '{print$2}'|awk '{print$1}'
	;;
max_listen_queue)
	 curl   -O /dev/null -s  ${url_php}|grep "max listen queue" |awk  -F ':' '{print$2}'|awk '{print$1}'
	;;
listen_queue_len)
	 curl   -O /dev/null -s  ${url_php}|grep "listen queue len" |awk  -F ':' '{print$2}'|awk '{print$1}'
	;;
idle_processes)
	 curl   -O /dev/null -s  ${url_php}|grep "idle processes" |awk  -F ':' '{print$2}'|awk '{print$1}'
	;;
active_processes)
	 curl   -O /dev/null -s  ${url_php}|grep "active processes" |awk  -F ':' '{print$2}'|awk '{print$1}'
	;;
total_processes)
	 curl   -O /dev/null -s  ${url_php}|grep "total processes" |awk  -F ':' '{print$2}'|awk '{print$1}'
	;;
max_active_processes)
	 curl   -O /dev/null -s  ${url_php}|grep "max active processes" |awk  -F ':' '{print$2}'|awk '{print$1}'
	;;
max_children_reached)
	 curl   -O /dev/null -s  ${url_php}|grep "max children reached" |awk  -F ':' '{print$2}'|awk '{print$1}'
	;;
slow_requests)
	 curl   -O /dev/null -s  ${url_php}|grep "slow requests" |awk  -F ':' '{print$2}'|awk '{print$1}'
	;;
*)
	echo "not support"
esac
