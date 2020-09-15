#!/bin/bash

# conf selinux
sudo setenforce 0
sudo sed -i 's/^SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config

# install and conf zabbix agent
sudo yum -y install https://repo.zabbix.com/zabbix/5.0/rhel/7/x86_64/zabbix-release-5.0-1.el7.noarch.rpm
sudo yum install -y zabbix-agent

# min conf rules for zabbix-agent
sudo sed -i 's!Server=127.0.0.1!Server='${zabbix_ip}'!' /etc/zabbix/zabbix_agentd.conf
sudo sed -i 's!ServerActive=127.0.0.1!ServerActive='${zabbix_ip}'!' /etc/zabbix/zabbix_agentd.conf
sudo sed -i 's!Hostname=Zabbix server!Hostname=zabbix-client!' /etc/zabbix/zabbix_agentd.conf
sudo sed -i 's!# HostMetadataItem=!HostMetadataItem=system.uname!' /etc/zabbix/zabbix_agentd.conf

# install apache for tests
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd

sudo systemctl start zabbix-agent
sudo systemctl enable zabbix-agent

# install tomcat 

sudo yum install -y java-1.8.0-openjdk

sudo yum install -y tomcat wget tomcat-admin-webapps tomcat-docs-webapp tomcat-javadoc tomcat-webapps
wget -P /var/lib/tomcat/webapps/ https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war
chown tomcat:tomcat /var/lib/tomcat/webapps/sample.war
sudo chmod 775 /var/lib/tomcat/webapps/sample.war
sudo chmod 777 -R /usr/share/tomcat/logs/

sudo systemctl enable tomcat
sudo systemctl start tomcat

#https://sysadminwork.com/monitoring-website-with-zabbix/ used for create alert

