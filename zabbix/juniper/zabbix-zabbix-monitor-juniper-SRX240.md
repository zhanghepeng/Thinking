﻿---
title: 'zabbix# zabbix3.0监控juniper-SRX240'
date: 2016-04-12 11:25:38
categories: zabbix
toc: true
tags:
---

`使用zabbix3 来监控juniper SRX240防火墙`

##### 1,juniper SRX-240 模版地址:
	https://share.zabbix.com/network_devices/juniper/juniper-srx-series 下载相对应的模版
##### 2,开启防火墙snmp协议
		略
##### 3,模版描述:
```
      This template is for the monitoring of Juniper SRX series firewall hardware via SNMP.

      It requires no additional files or components - just add the template and you're done.

      The template is based on one I found elsewhere, which I have made corrections and adjustments to, in addition to fixing Zabbix 3.x support.

      Monitors the following items:

      Device availability (ping check)
      Alarm status (red / yellow)
      5 minute load average
      CPU use (RE and PFE)
      Memory use (RE and PFE)
      Flow sessions (max, current and available)
      Device temperature
      Interfaces
      Inbound discarded packets
      Inbound errors
      Inbound traffic
      Outbound discarded packets
      Outbound errors
      Outbound traffic
      Discovery will detect your ports and VLANs, and this will work in virtual chassis configurations.

      Tested with the following hardware:

      SRX240
      SRX210
      All suggestions, edits and ideas are welcome!
```
##### 4,zabbix 导入juniper模版
```
<?xml version="1.0" encoding="UTF-8"?>
<zabbix_export>
    <version>3.0</version>
    <date>2016-03-04T17:32:21Z</date>
    <groups>
        <group>
            <name>Networking Hardware</name>
        </group>
        <group>
            <name>Templates</name>
        </group>
    </groups>
    <templates>
        <template>
            <template>Template Juniper SRX</template>
            <name>Template Juniper SRX</name>
            <description/>
            <groups>
                <group>
                    <name>Networking Hardware</name>
                </group>
                <group>
                    <name>Templates</name>
                </group>
            </groups>
            <applications>
                <application>
                    <name>Device Health</name>
                </application>
                <application>
                    <name>Device Properties</name>
                </application>
                <application>
                    <name>Interfaces</name>
                </application>
                <application>
                    <name>Performance</name>
                </application>
            </applications>
            <items>
                <item>
                    <name>Ping check</name>
                    <type>3</type>
                    <snmp_community/>
                    <multiplier>0</multiplier>
                    <snmp_oid/>
                    <key>icmpping</key>
                    <delay>30</delay>
                    <history>90</history>
                    <trends>365</trends>
                    <status>0</status>
                    <value_type>3</value_type>
                    <allowed_hosts/>
                    <units/>
                    <delta>0</delta>
                    <snmpv3_contextname/>
                    <snmpv3_securityname/>
                    <snmpv3_securitylevel>0</snmpv3_securitylevel>
                    <snmpv3_authprotocol>0</snmpv3_authprotocol>
                    <snmpv3_authpassphrase/>
                    <snmpv3_privprotocol>0</snmpv3_privprotocol>
                    <snmpv3_privpassphrase/>
                    <formula>1</formula>
                    <delay_flex/>
                    <params/>
                    <ipmi_sensor/>
                    <data_type>0</data_type>
                    <authtype>0</authtype>
                    <username/>
                    <password/>
                    <publickey/>
                    <privatekey/>
                    <port/>
                    <description/>
                    <inventory_link>0</inventory_link>
                    <applications>
                        <application>
                            <name>Device Health</name>
                        </application>
                    </applications>
                    <valuemap>
                        <name>Service state</name>
                    </valuemap>
                    <logtimefmt/>
                </item>
                <item>
                    <name>Flow sessions (Available)</name>
                    <type>15</type>
                    <snmp_community/>
                    <multiplier>0</multiplier>
                    <snmp_oid/>
                    <key>jnxJsSPUMonitoringAvailableFlowSession.0</key>
                    <delay>60</delay>
                    <history>90</history>
                    <trends>365</trends>
                    <status>0</status>
                    <value_type>3</value_type>
                    <allowed_hosts/>
                    <units>%</units>
                    <delta>0</delta>
                    <snmpv3_contextname/>
                    <snmpv3_securityname/>
                    <snmpv3_securitylevel>0</snmpv3_securitylevel>
                    <snmpv3_authprotocol>0</snmpv3_authprotocol>
                    <snmpv3_authpassphrase/>
                    <snmpv3_privprotocol>0</snmpv3_privprotocol>
                    <snmpv3_privpassphrase/>
                    <formula>1</formula>
                    <delay_flex/>
                    <params>((last(&quot;jnxJsSPUMonitoringMaxFlowSession.0&quot;)-last(&quot;jnxJsSPUMonitoringCurrentFlowSession.0&quot;))/last(&quot;jnxJsSPUMonitoringMaxFlowSession.0&quot;))*100</params>
                    <ipmi_sensor/>
                    <data_type>0</data_type>
                    <authtype>0</authtype>
                    <username/>
                    <password/>
                    <publickey/>
                    <privatekey/>
                    <port/>
                    <description/>
                    <inventory_link>0</inventory_link>
                    <applications>
                        <application>
                            <name>Performance</name>
                        </application>
                    </applications>
                    <valuemap/>
                    <logtimefmt/>
                </item>
                <item>
                    <name>Node 0 PFE CPU usage</name>
                    <type>4</type>
                    <snmp_community>public</snmp_community>
                    <multiplier>0</multiplier>
                    <snmp_oid>1.3.6.1.4.1.2636.3.39.1.12.1.1.1.4.0</snmp_oid>
                    <key>jnxJsSPUMonitoringCPUUsage.0</key>
                    <delay>30</delay>
                    <history>90</history>
                    <trends>365</trends>
                    <status>0</status>
                    <value_type>3</value_type>
                    <allowed_hosts/>
                    <units>%</units>
                    <delta>0</delta>
                    <snmpv3_contextname/>
                    <snmpv3_securityname/>
                    <snmpv3_securitylevel>0</snmpv3_securitylevel>
                    <snmpv3_authprotocol>0</snmpv3_authprotocol>
                    <snmpv3_authpassphrase/>
                    <snmpv3_privprotocol>0</snmpv3_privprotocol>
                    <snmpv3_privpassphrase/>
                    <formula>1</formula>
                    <delay_flex/>
                    <params/>
                    <ipmi_sensor/>
                    <data_type>0</data_type>
                    <authtype>0</authtype>
                    <username/>
                    <password/>
                    <publickey/>
                    <privatekey/>
                    <port>161</port>
                    <description/>
                    <inventory_link>0</inventory_link>
                    <applications>
                        <application>
                            <name>Performance</name>
                        </application>
                    </applications>
                    <valuemap/>
                    <logtimefmt/>
                </item>
                <item>
                    <name>Node1 PFE CPU usage</name>
                    <type>4</type>
                    <snmp_community>public</snmp_community>
                    <multiplier>0</multiplier>
                    <snmp_oid>1.3.6.1.4.1.2636.3.39.1.12.1.1.1.4.10</snmp_oid>
                    <key>jnxJsSPUMonitoringCPUUsage.10</key>
                    <delay>30</delay>
                    <history>90</history>
                    <trends>365</trends>
                    <status>0</status>
                    <value_type>3</value_type>
                    <allowed_hosts/>
                    <units>%</units>
                    <delta>0</delta>
                    <snmpv3_contextname/>
                    <snmpv3_securityname/>
                    <snmpv3_securitylevel>0</snmpv3_securitylevel>
                    <snmpv3_authprotocol>0</snmpv3_authprotocol>
                    <snmpv3_authpassphrase/>
                    <snmpv3_privprotocol>0</snmpv3_privprotocol>
                    <snmpv3_privpassphrase/>
                    <formula>1</formula>
                    <delay_flex/>
                    <params/>
                    <ipmi_sensor/>
                    <data_type>0</data_type>
                    <authtype>0</authtype>
                    <username/>
                    <password/>
                    <publickey/>
                    <privatekey/>
                    <port>161</port>
                    <description/>
                    <inventory_link>0</inventory_link>
                    <applications>
                        <application>
                            <name>Performance</name>
                        </application>
                    </applications>
                    <valuemap/>
                    <logtimefmt/>
                </item>
                <item>
                    <name>Flow sessions (Current)</name>
                    <type>4</type>
                    <snmp_community>public</snmp_community>
                    <multiplier>0</multiplier>
                    <snmp_oid>1.3.6.1.4.1.2636.3.39.1.12.1.1.1.6.0</snmp_oid>
                    <key>jnxJsSPUMonitoringCurrentFlowSession.0</key>
                    <delay>60</delay>
                    <history>90</history>
                    <trends>365</trends>
                    <status>0</status>
                    <value_type>3</value_type>
                    <allowed_hosts/>
                    <units>sessions</units>
                    <delta>0</delta>
                    <snmpv3_contextname/>
                    <snmpv3_securityname/>
                    <snmpv3_securitylevel>0</snmpv3_securitylevel>
                    <snmpv3_authprotocol>0</snmpv3_authprotocol>
                    <snmpv3_authpassphrase/>
                    <snmpv3_privprotocol>0</snmpv3_privprotocol>
                    <snmpv3_privpassphrase/>
                    <formula>1</formula>
                    <delay_flex/>
                    <params/>
                    <ipmi_sensor/>
                    <data_type>0</data_type>
                    <authtype>0</authtype>
                    <username/>
                    <password/>
                    <publickey/>
                    <privatekey/>
                    <port>161</port>
                    <description/>
                    <inventory_link>0</inventory_link>
                    <applications>
                        <application>
                            <name>Performance</name>
                        </application>
                    </applications>
                    <valuemap/>
                    <logtimefmt/>
                </item>
                <item>
                    <name>Flow sessions (Max)</name>
                    <type>4</type>
                    <snmp_community>public</snmp_community>
                    <multiplier>0</multiplier>
                    <snmp_oid>1.3.6.1.4.1.2636.3.39.1.12.1.1.1.7.0</snmp_oid>
                    <key>jnxJsSPUMonitoringMaxFlowSession.0</key>
                    <delay>60</delay>
                    <history>90</history>
                    <trends>365</trends>
                    <status>0</status>
                    <value_type>3</value_type>
                    <allowed_hosts/>
                    <units>sessions</units>
                    <delta>0</delta>
                    <snmpv3_contextname/>
                    <snmpv3_securityname/>
                    <snmpv3_securitylevel>0</snmpv3_securitylevel>
                    <snmpv3_authprotocol>0</snmpv3_authprotocol>
                    <snmpv3_authpassphrase/>
                    <snmpv3_privprotocol>0</snmpv3_privprotocol>
                    <snmpv3_privpassphrase/>
                    <formula>1</formula>
                    <delay_flex/>
                    <params/>
                    <ipmi_sensor/>
                    <data_type>0</data_type>
                    <authtype>0</authtype>
                    <username/>
                    <password/>
                    <publickey/>
                    <privatekey/>
                    <port>161</port>
                    <description/>
                    <inventory_link>0</inventory_link>
                    <applications>
                        <application>
                            <name>Performance</name>
                        </application>
                    </applications>
                    <valuemap/>
                    <logtimefmt/>
                </item>
                <item>
                    <name>Node 0 PFE Memory usage</name>
                    <type>4</type>
                    <snmp_community>public</snmp_community>
                    <multiplier>0</multiplier>
                    <snmp_oid>.1.3.6.1.4.1.2636.3.39.1.12.1.1.1.5.0</snmp_oid>
                    <key>jnxJsSPUMonitoringMemoryUsage.0</key>
                    <delay>30</delay>
                    <history>90</history>
                    <trends>365</trends>
                    <status>0</status>
                    <value_type>3</value_type>
                    <allowed_hosts/>
                    <units>%</units>
                    <delta>0</delta>
                    <snmpv3_contextname/>
                    <snmpv3_securityname/>
                    <snmpv3_securitylevel>0</snmpv3_securitylevel>
                    <snmpv3_authprotocol>0</snmpv3_authprotocol>
                    <snmpv3_authpassphrase/>
                    <snmpv3_privprotocol>0</snmpv3_privprotocol>
                    <snmpv3_privpassphrase/>
                    <formula>1</formula>
                    <delay_flex/>
                    <params/>
                    <ipmi_sensor/>
                    <data_type>0</data_type>
                    <authtype>0</authtype>
                    <username/>
                    <password/>
                    <publickey/>
                    <privatekey/>
                    <port>161</port>
                    <description/>
                    <inventory_link>0</inventory_link>
                    <applications>
                        <application>
                            <name>Performance</name>
                        </application>
                    </applications>
                    <valuemap/>
                    <logtimefmt/>
                </item>
                <item>
                    <name>Node 1 PFE Memory usage</name>
                    <type>4</type>
                    <snmp_community>public</snmp_community>
                    <multiplier>0</multiplier>
                    <snmp_oid>.1.3.6.1.4.1.2636.3.39.1.12.1.1.1.5.10</snmp_oid>
                    <key>jnxJsSPUMonitoringMemoryUsage.10</key>
                    <delay>30</delay>
                    <history>90</history>
                    <trends>365</trends>
                    <status>0</status>
                    <value_type>3</value_type>
                    <allowed_hosts/>
                    <units>%</units>
                    <delta>0</delta>
                    <snmpv3_contextname/>
                    <snmpv3_securityname/>
                    <snmpv3_securitylevel>0</snmpv3_securitylevel>
                    <snmpv3_authprotocol>0</snmpv3_authprotocol>
                    <snmpv3_authpassphrase/>
                    <snmpv3_privprotocol>0</snmpv3_privprotocol>
                    <snmpv3_privpassphrase/>
                    <formula>1</formula>
                    <delay_flex/>
                    <params/>
                    <ipmi_sensor/>
                    <data_type>0</data_type>
                    <authtype>0</authtype>
                    <username/>
                    <password/>
                    <publickey/>
                    <privatekey/>
                    <port>161</port>
                    <description/>
                    <inventory_link>0</inventory_link>
                    <applications>
                        <application>
                            <name>Performance</name>
                        </application>
                    </applications>
                    <valuemap/>
                    <logtimefmt/>
                </item>
                <item>
                    <name>Node 0 RE Memory usage</name>
                    <type>4</type>
                    <snmp_community>public</snmp_community>
                    <multiplier>0</multiplier>
                    <snmp_oid>.1.3.6.1.4.1.2636.3.1.13.1.11.9.1.0.0</snmp_oid>
                    <key>jnxOperatingBuffer.9.1.0.0</key>
                    <delay>30</delay>
                    <history>90</history>
                    <trends>365</trends>
                    <status>0</status>
                    <value_type>3</value_type>
                    <allowed_hosts/>
                    <units>%</units>
                    <delta>0</delta>
                    <snmpv3_contextname/>
                    <snmpv3_securityname/>
                    <snmpv3_securitylevel>0</snmpv3_securitylevel>
                    <snmpv3_authprotocol>0</snmpv3_authprotocol>
                    <snmpv3_authpassphrase/>
                    <snmpv3_privprotocol>0</snmpv3_privprotocol>
                    <snmpv3_privpassphrase/>
                    <formula>1</formula>
                    <delay_flex/>
                    <params/>
                    <ipmi_sensor/>
                    <data_type>0</data_type>
                    <authtype>0</authtype>
                    <username/>
                    <password/>
                    <publickey/>
                    <privatekey/>
                    <port>161</port>
                    <description/>
                    <inventory_link>0</inventory_link>
                    <applications>
                        <application>
                            <name>Performance</name>
                        </application>
                    </applications>
                    <valuemap/>
                    <logtimefmt/>
                </item>
                <item>
                    <name>Node 1 RE Memory usage</name>
                    <type>4</type>
                    <snmp_community>public</snmp_community>
                    <multiplier>0</multiplier>
                    <snmp_oid>1.3.6.1.4.1.2636.3.1.13.1.11.9.2.0.0</snmp_oid>
                    <key>jnxOperatingBuffer.9.2.0.0</key>
                    <delay>30</delay>
                    <history>90</history>
                    <trends>365</trends>
                    <status>0</status>
                    <value_type>3</value_type>
                    <allowed_hosts/>
                    <units>%</units>
                    <delta>0</delta>
                    <snmpv3_contextname/>
                    <snmpv3_securityname/>
                    <snmpv3_securitylevel>0</snmpv3_securitylevel>
                    <snmpv3_authprotocol>0</snmpv3_authprotocol>
                    <snmpv3_authpassphrase/>
                    <snmpv3_privprotocol>0</snmpv3_privprotocol>
                    <snmpv3_privpassphrase/>
                    <formula>1</formula>
                    <delay_flex/>
                    <params/>
                    <ipmi_sensor/>
                    <data_type>0</data_type>
                    <authtype>0</authtype>
                    <username/>
                    <password/>
                    <publickey/>
                    <privatekey/>
                    <port>161</port>
                    <description/>
                    <inventory_link>0</inventory_link>
                    <applications>
                        <application>
                            <name>Performance</name>
                        </application>
                    </applications>
                    <valuemap/>
                    <logtimefmt/>
                </item>
                <item>
                    <name>Node 0 RE CPU usage</name>
                    <type>4</type>
                    <snmp_community>public</snmp_community>
                    <multiplier>0</multiplier>
                    <snmp_oid>.1.3.6.1.4.1.2636.3.1.13.1.8.9.1.0.0</snmp_oid>
                    <key>jnxOperatingCPU.9.1.0.0</key>
                    <delay>30</delay>
                    <history>90</history>
                    <trends>365</trends>
                    <status>0</status>
                    <value_type>3</value_type>
                    <allowed_hosts/>
                    <units>%</units>
                    <delta>0</delta>
                    <snmpv3_contextname/>
                    <snmpv3_securityname/>
                    <snmpv3_securitylevel>0</snmpv3_securitylevel>
                    <snmpv3_authprotocol>0</snmpv3_authprotocol>
                    <snmpv3_authpassphrase/>
                    <snmpv3_privprotocol>0</snmpv3_privprotocol>
                    <snmpv3_privpassphrase/>
                    <formula>1</formula>
                    <delay_flex/>
                    <params/>
                    <ipmi_sensor/>
                    <data_type>0</data_type>
                    <authtype>0</authtype>
                    <username/>
                    <password/>
                    <publickey/>
                    <privatekey/>
                    <port>161</port>
                    <description/>
                    <inventory_link>0</inventory_link>
                    <applications>
                        <application>
                            <name>Performance</name>
                        </application>
                    </applications>
                    <valuemap/>
                    <logtimefmt/>
                </item>
                <item>
                    <name>Node 1 RE CPU usage</name>
                    <type>4</type>
                    <snmp_community>public</snmp_community>
                    <multiplier>0</multiplier>
                    <snmp_oid>.1.3.6.1.4.1.2636.3.1.13.1.8.9.2.0.0</snmp_oid>
                    <key>jnxOperatingCPU.9.2.0.0</key>
                    <delay>30</delay>
                    <history>90</history>
                    <trends>365</trends>
                    <status>0</status>
                    <value_type>3</value_type>
                    <allowed_hosts/>
                    <units>%</units>
                    <delta>0</delta>
                    <snmpv3_contextname/>
                    <snmpv3_securityname/>
                    <snmpv3_securitylevel>0</snmpv3_securitylevel>
                    <snmpv3_authprotocol>0</snmpv3_authprotocol>
                    <snmpv3_authpassphrase/>
                    <snmpv3_privprotocol>0</snmpv3_privprotocol>
                    <snmpv3_privpassphrase/>
                    <formula>1</formula>
                    <delay_flex/>
                    <params/>
                    <ipmi_sensor/>
                    <data_type>0</data_type>
                    <authtype>0</authtype>
                    <username/>
                    <password/>
                    <publickey/>
                    <privatekey/>
                    <port>161</port>
                    <description/>
                    <inventory_link>0</inventory_link>
                    <applications>
                        <application>
                            <name>Performance</name>
                        </application>
                    </applications>
                    <valuemap/>
                    <logtimefmt/>
                </item>
                <item>
                    <name>Node 0 CPU temperature</name>
                    <type>4</type>
                    <snmp_community>public</snmp_community>
                    <multiplier>0</multiplier>
                    <snmp_oid>.1.3.6.1.4.1.2636.3.1.13.1.7.9.1.0.0</snmp_oid>
                    <key>jnxOperatingTemp.9.1.0.0</key>
                    <delay>60</delay>
                    <history>90</history>
                    <trends>365</trends>
                    <status>0</status>
                    <value_type>3</value_type>
                    <allowed_hosts/>
                    <units>°C</units>
                    <delta>0</delta>
                    <snmpv3_contextname/>
                    <snmpv3_securityname/>
                    <snmpv3_securitylevel>0</snmpv3_securitylevel>
                    <snmpv3_authprotocol>0</snmpv3_authprotocol>
                    <snmpv3_authpassphrase/>
                    <snmpv3_privprotocol>0</snmpv3_privprotocol>
                    <snmpv3_privpassphrase/>
                    <formula>1</formula>
                    <delay_flex/>
                    <params/>
                    <ipmi_sensor/>
                    <data_type>0</data_type>
                    <authtype>0</authtype>
                    <username/>
                    <password/>
                    <publickey/>
                    <privatekey/>
                    <port>161</port>
                    <description/>
                    <inventory_link>0</inventory_link>
                    <applications>
                        <application>
                            <name>Device Health</name>
                        </application>
                    </applications>
                    <valuemap/>
                    <logtimefmt/>
                </item>
                <item>
                    <name>Node 1 CPU temperature</name>
                    <type>4</type>
                    <snmp_community>public</snmp_community>
                    <multiplier>0</multiplier>
                    <snmp_oid>.1.3.6.1.4.1.2636.3.1.13.1.7.9.2.0.0</snmp_oid>
                    <key>jnxOperatingTemp.9.2.0.0</key>
                    <delay>60</delay>
                    <history>90</history>
                    <trends>365</trends>
                    <status>0</status>
                    <value_type>3</value_type>
                    <allowed_hosts/>
                    <units>°C</units>
                    <delta>0</delta>
                    <snmpv3_contextname/>
                    <snmpv3_securityname/>
                    <snmpv3_securitylevel>0</snmpv3_securitylevel>
                    <snmpv3_authprotocol>0</snmpv3_authprotocol>
                    <snmpv3_authpassphrase/>
                    <snmpv3_privprotocol>0</snmpv3_privprotocol>
                    <snmpv3_privpassphrase/>
                    <formula>1</formula>
                    <delay_flex/>
                    <params/>
                    <ipmi_sensor/>
                    <data_type>0</data_type>
                    <authtype>0</authtype>
                    <username/>
                    <password/>
                    <publickey/>
                    <privatekey/>
                    <port>161</port>
                    <description/>
                    <inventory_link>0</inventory_link>
                    <applications>
                        <application>
                            <name>Device Health</name>
                        </application>
                    </applications>
                    <valuemap/>
                    <logtimefmt/>
                </item>
                <item>
                    <name>Red alarm</name>
                    <type>4</type>
                    <snmp_community>public</snmp_community>
                    <multiplier>0</multiplier>
                    <snmp_oid>.1.3.6.1.4.1.2636.3.4.2.3.1.0</snmp_oid>
                    <key>jnxRedAlarmState</key>
                    <delay>30</delay>
                    <history>90</history>
                    <trends>365</trends>
                    <status>0</status>
                    <value_type>3</value_type>
                    <allowed_hosts/>
                    <units>alarm(s)</units>
                    <delta>0</delta>
                    <snmpv3_contextname/>
                    <snmpv3_securityname/>
                    <snmpv3_securitylevel>0</snmpv3_securitylevel>
                    <snmpv3_authprotocol>0</snmpv3_authprotocol>
                    <snmpv3_authpassphrase/>
                    <snmpv3_privprotocol>0</snmpv3_privprotocol>
                    <snmpv3_privpassphrase/>
                    <formula>1</formula>
                    <delay_flex/>
                    <params/>
                    <ipmi_sensor/>
                    <data_type>0</data_type>
                    <authtype>0</authtype>
                    <username/>
                    <password/>
                    <publickey/>
                    <privatekey/>
                    <port>161</port>
                    <description/>
                    <inventory_link>0</inventory_link>
                    <applications>
                        <application>
                            <name>Device Health</name>
                        </application>
                    </applications>
                    <valuemap/>
                    <logtimefmt/>
                </item>
                <item>
                    <name>Yellow alarm</name>
                    <type>4</type>
                    <snmp_community>public</snmp_community>
                    <multiplier>0</multiplier>
                    <snmp_oid>.1.3.6.1.4.1.2636.3.4.2.2.1.0</snmp_oid>
                    <key>jnxYellowAlarmState</key>
                    <delay>60</delay>
                    <history>90</history>
                    <trends>365</trends>
                    <status>0</status>
                    <value_type>3</value_type>
                    <allowed_hosts/>
                    <units>alarm(s)</units>
                    <delta>0</delta>
                    <snmpv3_contextname/>
                    <snmpv3_securityname/>
                    <snmpv3_securitylevel>0</snmpv3_securitylevel>
                    <snmpv3_authprotocol>0</snmpv3_authprotocol>
                    <snmpv3_authpassphrase/>
                    <snmpv3_privprotocol>0</snmpv3_privprotocol>
                    <snmpv3_privpassphrase/>
                    <formula>1</formula>
                    <delay_flex/>
                    <params/>
                    <ipmi_sensor/>
                    <data_type>0</data_type>
                    <authtype>0</authtype>
                    <username/>
                    <password/>
                    <publickey/>
                    <privatekey/>
                    <port>161</port>
                    <description/>
                    <inventory_link>0</inventory_link>
                    <applications>
                        <application>
                            <name>Device Health</name>
                        </application>
                    </applications>
                    <valuemap/>
                    <logtimefmt/>
                </item>
                <item>
                    <name>Uptime</name>
                    <type>4</type>
                    <snmp_community>public</snmp_community>
                    <multiplier>1</multiplier>
                    <snmp_oid>.1.3.6.1.2.1.1.3.0</snmp_oid>
                    <key>Uptime</key>
                    <delay>60</delay>
                    <history>90</history>
                    <trends>365</trends>
                    <status>0</status>
                    <value_type>3</value_type>
                    <allowed_hosts/>
                    <units>s</units>
                    <delta>0</delta>
                    <snmpv3_contextname/>
                    <snmpv3_securityname/>
                    <snmpv3_securitylevel>0</snmpv3_securitylevel>
                    <snmpv3_authprotocol>0</snmpv3_authprotocol>
                    <snmpv3_authpassphrase/>
                    <snmpv3_privprotocol>0</snmpv3_privprotocol>
                    <snmpv3_privpassphrase/>
                    <formula>0.01</formula>
                    <delay_flex/>
                    <params/>
                    <ipmi_sensor/>
                    <data_type>0</data_type>
                    <authtype>0</authtype>
                    <username/>
                    <password/>
                    <publickey/>
                    <privatekey/>
                    <port>161</port>
                    <description/>
                    <inventory_link>0</inventory_link>
                    <applications>
                        <application>
                            <name>Device Health</name>
                        </application>
                    </applications>
                    <valuemap/>
                    <logtimefmt/>
                </item>
            </items>
            <discovery_rules>
                <discovery_rule>
                    <name>JunOS Interfaces</name>
                    <type>4</type>
                    <snmp_community>{$SNMP_COMMUNITY}</snmp_community>
                    <snmp_oid>discovery[{#SNMPVALUE},1.3.6.1.2.1.2.2.1.2]</snmp_oid>
                    <key>discovery.ifDescr</key>
                    <delay>300</delay>
                    <status>0</status>
                    <allowed_hosts/>
                    <snmpv3_contextname/>
                    <snmpv3_securityname/>
                    <snmpv3_securitylevel>0</snmpv3_securitylevel>
                    <snmpv3_authprotocol>0</snmpv3_authprotocol>
                    <snmpv3_authpassphrase/>
                    <snmpv3_privprotocol>0</snmpv3_privprotocol>
                    <snmpv3_privpassphrase/>
                    <delay_flex/>
                    <params/>
                    <ipmi_sensor/>
                    <authtype>0</authtype>
                    <username/>
                    <password/>
                    <publickey/>
                    <privatekey/>
                    <port/>
                    <filter>
                        <evaltype>0</evaltype>
                        <formula/>
                        <conditions>
                            <condition>
                                <macro>{#SNMPVALUE}</macro>
                                <value>^(fe|ge|xe)-[0-9]+\/[0-9]+\/[0-9]+\.[0-9]+$|^(fe|ge|xe)-[0-9]+\/[0-9]+\/[0-9]+$|^(ae|reth|st)[0-9]+\.[0-9]+$|^(ae|reth|st)[0-9]$|^vcp-[0-9]+$|^vlan.[0-9]+$</value>
                                <operator>8</operator>
                                <formulaid>A</formulaid>
                            </condition>
                        </conditions>
                    </filter>
                    <lifetime>30</lifetime>
                    <description/>
                    <item_prototypes>
                        <item_prototype>
                            <name>{#SNMPVALUE} - Inbound discarded packets</name>
                            <type>4</type>
                            <snmp_community>public</snmp_community>
                            <multiplier>0</multiplier>
                            <snmp_oid>.1.3.6.1.2.1.2.2.1.13.{#SNMPINDEX}</snmp_oid>
                            <key>.1.3.6.1.2.1.2.2.1.13.[{#SNMPINDEX}]</key>
                            <delay>60</delay>
                            <history>7</history>
                            <trends>365</trends>
                            <status>0</status>
                            <value_type>3</value_type>
                            <allowed_hosts/>
                            <units/>
                            <delta>1</delta>
                            <snmpv3_contextname/>
                            <snmpv3_securityname/>
                            <snmpv3_securitylevel>0</snmpv3_securitylevel>
                            <snmpv3_authprotocol>0</snmpv3_authprotocol>
                            <snmpv3_authpassphrase/>
                            <snmpv3_privprotocol>0</snmpv3_privprotocol>
                            <snmpv3_privpassphrase/>
                            <formula>1</formula>
                            <delay_flex/>
                            <params/>
                            <ipmi_sensor/>
                            <data_type>0</data_type>
                            <authtype>0</authtype>
                            <username/>
                            <password/>
                            <publickey/>
                            <privatekey/>
                            <port/>
                            <description/>
                            <inventory_link>0</inventory_link>
                            <applications>
                                <application>
                                    <name>Interfaces</name>
                                </application>
                            </applications>
                            <valuemap/>
                            <logtimefmt/>
                            <application_prototypes/>
                        </item_prototype>
                        <item_prototype>
                            <name>{#SNMPVALUE} - Inbound traffic</name>
                            <type>4</type>
                            <snmp_community>public</snmp_community>
                            <multiplier>1</multiplier>
                            <snmp_oid>1.3.6.1.2.1.2.2.1.10.{#SNMPINDEX}</snmp_oid>
                            <key>1.3.6.1.2.1.2.2.1.10.[{#SNMPINDEX}]</key>
                            <delay>60</delay>
                            <history>7</history>
                            <trends>365</trends>
                            <status>0</status>
                            <value_type>0</value_type>
                            <allowed_hosts/>
                            <units>bps</units>
                            <delta>1</delta>
                            <snmpv3_contextname/>
                            <snmpv3_securityname/>
                            <snmpv3_securitylevel>0</snmpv3_securitylevel>
                            <snmpv3_authprotocol>0</snmpv3_authprotocol>
                            <snmpv3_authpassphrase/>
                            <snmpv3_privprotocol>0</snmpv3_privprotocol>
                            <snmpv3_privpassphrase/>
                            <formula>8</formula>
                            <delay_flex/>
                            <params/>
                            <ipmi_sensor/>
                            <data_type>0</data_type>
                            <authtype>0</authtype>
                            <username/>
                            <password/>
                            <publickey/>
                            <privatekey/>
                            <port/>
                            <description/>
                            <inventory_link>0</inventory_link>
                            <applications>
                                <application>
                                    <name>Interfaces</name>
                                </application>
                            </applications>
                            <valuemap/>
                            <logtimefmt/>
                            <application_prototypes/>
                        </item_prototype>
                        <item_prototype>
                            <name>{#SNMPVALUE} - Inbound errors</name>
                            <type>4</type>
                            <snmp_community>public</snmp_community>
                            <multiplier>0</multiplier>
                            <snmp_oid>1.3.6.1.2.1.2.2.1.14.{#SNMPINDEX}</snmp_oid>
                            <key>1.3.6.1.2.1.2.2.1.14.[{#SNMPINDEX}]</key>
                            <delay>60</delay>
                            <history>7</history>
                            <trends>365</trends>
                            <status>0</status>
                            <value_type>3</value_type>
                            <allowed_hosts/>
                            <units/>
                            <delta>1</delta>
                            <snmpv3_contextname/>
                            <snmpv3_securityname/>
                            <snmpv3_securitylevel>0</snmpv3_securitylevel>
                            <snmpv3_authprotocol>0</snmpv3_authprotocol>
                            <snmpv3_authpassphrase/>
                            <snmpv3_privprotocol>0</snmpv3_privprotocol>
                            <snmpv3_privpassphrase/>
                            <formula>1</formula>
                            <delay_flex/>
                            <params/>
                            <ipmi_sensor/>
                            <data_type>0</data_type>
                            <authtype>0</authtype>
                            <username/>
                            <password/>
                            <publickey/>
                            <privatekey/>
                            <port/>
                            <description/>
                            <inventory_link>0</inventory_link>
                            <applications>
                                <application>
                                    <name>Interfaces</name>
                                </application>
                            </applications>
                            <valuemap/>
                            <logtimefmt/>
                            <application_prototypes/>
                        </item_prototype>
                        <item_prototype>
                            <name>{#SNMPVALUE} - Outbound traffic</name>
                            <type>4</type>
                            <snmp_community>public</snmp_community>
                            <multiplier>1</multiplier>
                            <snmp_oid>1.3.6.1.2.1.2.2.1.16.{#SNMPINDEX}</snmp_oid>
                            <key>1.3.6.1.2.1.2.2.1.16.[{#SNMPINDEX}]</key>
                            <delay>60</delay>
                            <history>7</history>
                            <trends>365</trends>
                            <status>0</status>
                            <value_type>0</value_type>
                            <allowed_hosts/>
                            <units>bps</units>
                            <delta>1</delta>
                            <snmpv3_contextname/>
                            <snmpv3_securityname/>
                            <snmpv3_securitylevel>0</snmpv3_securitylevel>
                            <snmpv3_authprotocol>0</snmpv3_authprotocol>
                            <snmpv3_authpassphrase/>
                            <snmpv3_privprotocol>0</snmpv3_privprotocol>
                            <snmpv3_privpassphrase/>
                            <formula>8</formula>
                            <delay_flex/>
                            <params/>
                            <ipmi_sensor/>
                            <data_type>0</data_type>
                            <authtype>0</authtype>
                            <username/>
                            <password/>
                            <publickey/>
                            <privatekey/>
                            <port/>
                            <description/>
                            <inventory_link>0</inventory_link>
                            <applications>
                                <application>
                                    <name>Interfaces</name>
                                </application>
                            </applications>
                            <valuemap/>
                            <logtimefmt/>
                            <application_prototypes/>
                        </item_prototype>
                        <item_prototype>
                            <name>{#SNMPVALUE} - Outbound discarded packets</name>
                            <type>4</type>
                            <snmp_community>public</snmp_community>
                            <multiplier>0</multiplier>
                            <snmp_oid>1.3.6.1.2.1.2.2.1.19.{#SNMPINDEX}</snmp_oid>
                            <key>1.3.6.1.2.1.2.2.1.19.[{#SNMPINDEX}]</key>
                            <delay>60</delay>
                            <history>7</history>
                            <trends>365</trends>
                            <status>0</status>
                            <value_type>3</value_type>
                            <allowed_hosts/>
                            <units/>
                            <delta>1</delta>
                            <snmpv3_contextname/>
                            <snmpv3_securityname/>
                            <snmpv3_securitylevel>0</snmpv3_securitylevel>
                            <snmpv3_authprotocol>0</snmpv3_authprotocol>
                            <snmpv3_authpassphrase/>
                            <snmpv3_privprotocol>0</snmpv3_privprotocol>
                            <snmpv3_privpassphrase/>
                            <formula>1</formula>
                            <delay_flex/>
                            <params/>
                            <ipmi_sensor/>
                            <data_type>0</data_type>
                            <authtype>0</authtype>
                            <username/>
                            <password/>
                            <publickey/>
                            <privatekey/>
                            <port/>
                            <description/>
                            <inventory_link>0</inventory_link>
                            <applications>
                                <application>
                                    <name>Interfaces</name>
                                </application>
                            </applications>
                            <valuemap/>
                            <logtimefmt/>
                            <application_prototypes/>
                        </item_prototype>
                        <item_prototype>
                            <name>{#SNMPVALUE} - Outbound errors</name>
                            <type>4</type>
                            <snmp_community>public</snmp_community>
                            <multiplier>0</multiplier>
                            <snmp_oid>1.3.6.1.2.1.2.2.1.20.{#SNMPINDEX}</snmp_oid>
                            <key>1.3.6.1.2.1.2.2.1.20.[{#SNMPINDEX}]</key>
                            <delay>60</delay>
                            <history>7</history>
                            <trends>365</trends>
                            <status>0</status>
                            <value_type>3</value_type>
                            <allowed_hosts/>
                            <units/>
                            <delta>1</delta>
                            <snmpv3_contextname/>
                            <snmpv3_securityname/>
                            <snmpv3_securitylevel>0</snmpv3_securitylevel>
                            <snmpv3_authprotocol>0</snmpv3_authprotocol>
                            <snmpv3_authpassphrase/>
                            <snmpv3_privprotocol>0</snmpv3_privprotocol>
                            <snmpv3_privpassphrase/>
                            <formula>1</formula>
                            <delay_flex/>
                            <params/>
                            <ipmi_sensor/>
                            <data_type>0</data_type>
                            <authtype>0</authtype>
                            <username/>
                            <password/>
                            <publickey/>
                            <privatekey/>
                            <port/>
                            <description/>
                            <inventory_link>0</inventory_link>
                            <applications>
                                <application>
                                    <name>Interfaces</name>
                                </application>
                            </applications>
                            <valuemap/>
                            <logtimefmt/>
                            <application_prototypes/>
                        </item_prototype>
                    </item_prototypes>
                    <trigger_prototypes/>
                    <graph_prototypes>
                        <graph_prototype>
                            <name>Interface {#SNMPVALUE}</name>
                            <width>900</width>
                            <height>200</height>
                            <yaxismin>0.0000</yaxismin>
                            <yaxismax>100.0000</yaxismax>
                            <show_work_period>1</show_work_period>
                            <show_triggers>1</show_triggers>
                            <type>0</type>
                            <show_legend>1</show_legend>
                            <show_3d>0</show_3d>
                            <percent_left>0.0000</percent_left>
                            <percent_right>0.0000</percent_right>
                            <ymin_type_1>0</ymin_type_1>
                            <ymax_type_1>0</ymax_type_1>
                            <ymin_item_1>0</ymin_item_1>
                            <ymax_item_1>0</ymax_item_1>
                            <graph_items>
                                <graph_item>
                                    <sortorder>0</sortorder>
                                    <drawtype>1</drawtype>
                                    <color>2618B1</color>
                                    <yaxisside>1</yaxisside>
                                    <calc_fnc>2</calc_fnc>
                                    <type>0</type>
                                    <item>
                                        <host>Template Juniper SRX</host>
                                        <key>1.3.6.1.2.1.2.2.1.10.[{#SNMPINDEX}]</key>
                                    </item>
                                </graph_item>
                                <graph_item>
                                    <sortorder>1</sortorder>
                                    <drawtype>0</drawtype>
                                    <color>594CD8</color>
                                    <yaxisside>1</yaxisside>
                                    <calc_fnc>2</calc_fnc>
                                    <type>0</type>
                                    <item>
                                        <host>Template Juniper SRX</host>
                                        <key>.1.3.6.1.2.1.2.2.1.13.[{#SNMPINDEX}]</key>
                                    </item>
                                </graph_item>
                                <graph_item>
                                    <sortorder>2</sortorder>
                                    <drawtype>0</drawtype>
                                    <color>7B72D8</color>
                                    <yaxisside>1</yaxisside>
                                    <calc_fnc>2</calc_fnc>
                                    <type>0</type>
                                    <item>
                                        <host>Template Juniper SRX</host>
                                        <key>1.3.6.1.2.1.2.2.1.14.[{#SNMPINDEX}]</key>
                                    </item>
                                </graph_item>
                                <graph_item>
                                    <sortorder>3</sortorder>
                                    <drawtype>2</drawtype>
                                    <color>FFC600</color>
                                    <yaxisside>1</yaxisside>
                                    <calc_fnc>2</calc_fnc>
                                    <type>0</type>
                                    <item>
                                        <host>Template Juniper SRX</host>
                                        <key>1.3.6.1.2.1.2.2.1.16.[{#SNMPINDEX}]</key>
                                    </item>
                                </graph_item>
                                <graph_item>
                                    <sortorder>4</sortorder>
                                    <drawtype>0</drawtype>
                                    <color>FFD440</color>
                                    <yaxisside>1</yaxisside>
                                    <calc_fnc>2</calc_fnc>
                                    <type>0</type>
                                    <item>
                                        <host>Template Juniper SRX</host>
                                        <key>1.3.6.1.2.1.2.2.1.19.[{#SNMPINDEX}]</key>
                                    </item>
                                </graph_item>
                                <graph_item>
                                    <sortorder>5</sortorder>
                                    <drawtype>0</drawtype>
                                    <color>FFE073</color>
                                    <yaxisside>1</yaxisside>
                                    <calc_fnc>2</calc_fnc>
                                    <type>0</type>
                                    <item>
                                        <host>Template Juniper SRX</host>
                                        <key>1.3.6.1.2.1.2.2.1.20.[{#SNMPINDEX}]</key>
                                    </item>
                                </graph_item>
                            </graph_items>
                        </graph_prototype>
                    </graph_prototypes>
                    <host_prototypes/>
                </discovery_rule>
            </discovery_rules>
            <macros/>
            <templates/>
            <screens/>
        </template>
    </templates>
    <triggers>
        <trigger>
            <expression>{Template Juniper SRX:jnxJsSPUMonitoringAvailableFlowSession.0.last(0)}&lt;10</expression>
            <name>Flow sessions (10% Available)</name>
            <url/>
            <status>0</status>
            <priority>4</priority>
            <description>&gt;90% Reaching Device limits&#13;
&#13;
Actions:&#13;
Review traffic patterns&#13;
Look for sessions with high inactivity timeouts&#13;
Review Device type</description>
            <type>0</type>
            <dependencies/>
        </trigger>
        <trigger>
            <expression>{Template Juniper SRX:jnxJsSPUMonitoringAvailableFlowSession.0.last(0)}&lt;20</expression>
            <name>Flow sessions (20% Available)</name>
            <url/>
            <status>0</status>
            <priority>2</priority>
            <description>80% -90 of Max PFE Sessions may be considered normal depending upon network traffic but requires investigation if increase is sudden&#13;
&#13;
Actions:&#13;
Review traffic patterns&#13;
Look for sessions with high inactivity timeouts&#13;
Review Device type</description>
            <type>0</type>
            <dependencies/>
        </trigger>
        <trigger>
            <expression>{Template Juniper SRX:jnxOperatingTemp.9.1.0.0.min(60)}&gt;65</expression>
            <name>High CPU temperature on {HOSTNAME} node 0</name>
            <url/>
            <status>0</status>
            <priority>3</priority>
            <description/>
            <type>0</type>
            <dependencies/>
        </trigger>
        <trigger>
            <expression>{Template Juniper SRX:jnxOperatingTemp.9.2.0.0.min(60)}&gt;65</expression>
            <name>High CPU temperature on {HOSTNAME} node 1</name>
            <url/>
            <status>0</status>
            <priority>3</priority>
            <description/>
            <type>0</type>
            <dependencies/>
        </trigger>
        <trigger>
            <expression>{Template Juniper SRX:icmpping.sum(#3)}=0 or ({TRIGGER.VALUE}=1 and {Template Juniper SRX:icmpping.sum(#3)}&lt;&gt;3)</expression>
            <name>Ping check</name>
            <url/>
            <status>0</status>
            <priority>5</priority>
            <description>The firewall device has stopped responding. This could indicate a failure and needs to be investigated.</description>
            <type>0</type>
            <dependencies/>
        </trigger>
        <trigger>
            <expression>{Template Juniper SRX:jnxRedAlarmState.last(0)}&lt;&gt;2</expression>
            <name>Red alarm on {HOSTNAME}</name>
            <url/>
            <status>0</status>
            <priority>4</priority>
            <description/>
            <type>0</type>
            <dependencies/>
        </trigger>
        <trigger>
            <expression>{Template Juniper SRX:jnxYellowAlarmState.last(0)}&lt;&gt;2</expression>
            <name>Yellow alarm on {HOSTNAME}</name>
            <url/>
            <status>0</status>
            <priority>3</priority>
            <description/>
            <type>0</type>
            <dependencies/>
        </trigger>
        <trigger>
            <expression>{Template Juniper SRX:Uptime.last(0)}&lt;600</expression>
            <name>{HOSTNAME} Has just been restarted</name>
            <url/>
            <status>0</status>
            <priority>3</priority>
            <description/>
            <type>0</type>
            <dependencies/>
        </trigger>
        <trigger>
            <expression>{Template Juniper SRX:jnxJsSPUMonitoringCPUUsage.0.min(60)}&gt;95</expression>
            <name>{HOSTNAME} node 0 high PFE CPU usage</name>
            <url/>
            <status>0</status>
            <priority>3</priority>
            <description>&gt;95% Device responsiveness for transit traffic is likely to be impacted including session buildup&#13;
&#13;
Actions:&#13;
Review Traffic pattern&#13;
Review PPS&#13;
Review Session&#13;
counts</description>
            <type>0</type>
            <dependencies/>
        </trigger>
        <trigger>
            <expression>{Template Juniper SRX:jnxJsSPUMonitoringMemoryUsage.0.min(30)}&gt;95</expression>
            <name>{HOSTNAME} node 0 high PFE memory usage</name>
            <url/>
            <status>0</status>
            <priority>3</priority>
            <description>&gt;95%  Transit traffic may be impacted due to inability for forwarding operations&#13;
&#13;
Actions:&#13;
Review system logs&#13;
Verify configuration for unused features that be removed&#13;
Disable non needed ALGs</description>
            <type>0</type>
            <dependencies/>
        </trigger>
        <trigger>
            <expression>{Template Juniper SRX:jnxOperatingCPU.9.1.0.0.min(60)}&gt;95</expression>
            <name>{HOSTNAME} node 0 high RE CPU usage</name>
            <url/>
            <status>0</status>
            <priority>3</priority>
            <description>&gt;95% Device responsiveness for self traffic is likely to be impacted&#13;
&#13;
Actions:&#13;
Disable traceoptions&#13;
Clean up storage&#13;
Verify system processes</description>
            <type>0</type>
            <dependencies/>
        </trigger>
        <trigger>
            <expression>{Template Juniper SRX:jnxOperatingBuffer.9.1.0.0.min(30)}&gt;95</expression>
            <name>{HOSTNAME} node 0 high RE memory usage</name>
            <url/>
            <status>0</status>
            <priority>3</priority>
            <description>&gt;95% Device will begin active memory clean up attempts&#13;
&#13;
Actions:&#13;
Verify routing table size&#13;
Verify System Processes in use &#13;
Review system logs</description>
            <type>0</type>
            <dependencies/>
        </trigger>
        <trigger>
            <expression>{Template Juniper SRX:jnxJsSPUMonitoringCPUUsage.10.min(60)}&gt;95</expression>
            <name>{HOSTNAME} node 1 high PFE CPU usage</name>
            <url/>
            <status>0</status>
            <priority>3</priority>
            <description>&gt;95% Device responsiveness for transit traffic is likely to be impacted including session buildup&#13;
&#13;
Actions:&#13;
Review Traffic pattern&#13;
Review PPS&#13;
Review Session&#13;
counts</description>
            <type>0</type>
            <dependencies/>
        </trigger>
        <trigger>
            <expression>{Template Juniper SRX:jnxJsSPUMonitoringMemoryUsage.10.min(30)}&gt;95</expression>
            <name>{HOSTNAME} node 1 high PFE memory usage</name>
            <url/>
            <status>0</status>
            <priority>3</priority>
            <description>&gt;95%  Transit traffic may be impacted due to inability for forwarding operations&#13;
&#13;
Actions:&#13;
Review system logs&#13;
Verify configuration for unused features that be removed&#13;
Disable non needed ALGs</description>
            <type>0</type>
            <dependencies/>
        </trigger>
        <trigger>
            <expression>{Template Juniper SRX:jnxOperatingCPU.9.2.0.0.min(60)}&gt;95</expression>
            <name>{HOSTNAME} node 1 high RE CPU usage</name>
            <url/>
            <status>0</status>
            <priority>3</priority>
            <description>&gt;95% Device responsiveness for self traffic is likely to be impacted&#13;
&#13;
Actions:&#13;
Disable traceoptions&#13;
Clean up storage&#13;
Verify system processes</description>
            <type>0</type>
            <dependencies/>
        </trigger>
        <trigger>
            <expression>{Template Juniper SRX:jnxOperatingBuffer.9.2.0.0.min(30)}&gt;95</expression>
            <name>{HOSTNAME} node 1 high RE memory usage</name>
            <url/>
            <status>0</status>
            <priority>3</priority>
            <description>&gt;95% Device will begin active memory clean up attempts&#13;
&#13;
Actions:&#13;
Verify routing table size&#13;
Verify System Processes in use &#13;
Review system logs</description>
            <type>0</type>
            <dependencies/>
        </trigger>
    </triggers>
    <value_maps>
        <value_map>
            <name>Service state</name>
            <mappings>
                <mapping>
                    <value>0</value>
                    <newvalue>Down</newvalue>
                </mapping>
                <mapping>
                    <value>1</value>
                    <newvalue>Up</newvalue>
                </mapping>
            </mappings>
        </value_map>
    </value_maps>
</zabbix_export>
```