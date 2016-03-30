#!/bin/bash

user=sss
passwd=sss
port=$2
url=http://186.monitor:${port}/manager/status
http_url=http://186.monitor:${port}

function Free_memory {
curl -u ${user}:${passwd} $url 2>>/dev/null |grep h1|awk -F "</h1><p>" '{print$3}'|awk -F "Free memory:" '{print$2}'|awk '{print$1}'
}
function Total_memory {
curl -u ${user}:${passwd} $url 2>>/dev/null |grep h1|awk -F "</h1><p>" '{print$3}'|awk -F "Total memory:" '{print$2}'|awk '{print$1}'
}
function Max_memory {
curl -u ${user}:${passwd} $url 2>>/dev/null |grep h1|awk -F "</h1><p>" '{print$3}'|awk -F "Max memory:" '{print$2}'|awk '{print$1}'
}
function Max_threads {
curl -u ${user}:${passwd}  $url 2>>/dev/null |grep h1|awk -F "</h1><p>" '{print$4}'|awk -F 'Max threads:' '{print$2}'|awk '{print$1}'
}
function Current_thread_count {
curl -u ${user}:${passwd}  $url 2>>/dev/null |grep h1|awk -F "</h1><p>" '{print$4}'|awk -F 'Current thread count:' '{print$2}'|awk '{print$1}'
}
function Current_thread_busy {
curl -u ${user}:${passwd}  $url 2>>/dev/null |grep h1|awk -F "</h1><p>" '{print$4}'|awk -F 'Current thread busy:' '{print$2}'|awk '{print$1}'
}
function Keeped_alive_sockets_count {
curl -u ${user}:${passwd} $url 2>>/dev/null |grep h1|awk -F "</h1><p>" '{print$4}'|awk -F 'Keeped alive sockets count:' '{print$2}'|awk '{print$1}'|awk -F "<" '{print$1}'
}
function Max_processing_time {
curl   -u ${user}:${passwd} $url 2>>/dev/null |grep h1|awk -F "</h1><p>" '{print$4}'|awk -F 'Max processing time:' '{print$2}'|awk '{print$1}'
}
function Processing_time {
curl   -u ${user}:${passwd} $url 2>>/dev/null |grep h1|awk -F "</h1><p>" '{print$4}'|awk -F 'Processing time:' '{print$2}'|awk '{print$1}'
}
function Request_count {
curl   -u ${user}:${passwd} $url 2>>/dev/null |grep h1|awk -F "</h1><p>" '{print$4}'|awk -F 'Request count:' '{print$2}'|awk '{print$1}'
}
function Error_count {
curl   -u ${user}:${passwd} $url 2>>/dev/null |grep h1|awk -F "</h1><p>" '{print$4}'|awk -F 'Error count:' '{print$2}'|awk '{print$1}'
}
function received {
curl   -u ${user}:${passwd} $url 2>>/dev/null |grep h1|awk -F "</h1><p>" '{print$4}'|awk -F 'received:' '{print$2}'|awk '{print$1}'
}
function sent {
curl   -u ${user}:${passwd} $url 2>>/dev/null |grep h1|awk -F "</h1><p>" '{print$4}'|awk -F 'sent:' '{print$2}'|awk '{print$1}'
}
function http_code {
curl -I -o /dev/null ${http_url} -s -w %{http_code}
}

$1
