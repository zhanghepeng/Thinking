#!/usr/bin/env python
import os
import json
import sys

f = open("/etc/zabbix/scripts/Tomcat_Ports", "r")
ports = []
for port in f.readlines():
        r = port.split( )
        ports +=[{'{#'+r[0].upper()+'PORTS}':r[1]}]
print json.dumps({'data':ports},sort_keys=True,indent=4,separators=(',',':'))
