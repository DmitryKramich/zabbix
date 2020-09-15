#!/bin/bash

# conf selinux
sudo su
sudo setenforce 0
sudo sed -i 's/^SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config
#setsebool -P httpd_can_connect_zabbix on
#setsebool -P httpd_can_network_connect_db on

# install and conf db
sudo yum -y install mariadb mariadb-server
sudo /usr/bin/mysql_install_db --user=mysql --force
sudo systemctl start mariadb
sudo systemctl enable mariadb

mysql -uroot <<EOF
create database zabbix character set utf8 collate utf8_bin;
grant all privileges on zabbix.* to zabbix@'localhost' identified by 'zabbix';
FLUSH PRIVILEGES;
EOF

# install and configuring zabbix server + gui + agent + php-fpm
sudo yum -y install https://repo.zabbix.com/zabbix/5.0/rhel/7/x86_64/zabbix-release-5.0-1.el7.noarch.rpm
sudo yum clean all
sudo yum install -y zabbix-server-mysql zabbix-agent
sudo yum install -y centos-release-scl
sudo sed -i 's!enabled=0!enabled=1!' /etc/yum.repos.d/zabbix.repo
sudo yum install -y zabbix-web-mysql-scl zabbix-apache-conf-scl


zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -pzabbix zabbix
sudo sed -i '24c php_value[date.timezone] = Europe/Minsk' /etc/opt/rh/rh-php72/php-fpm.d/zabbix.conf

cat >> /etc/zabbix/zabbix_server.conf <<EOF
DBHost=localhost
DBName=zabbix
DBUser=zabbix
DBPassword=zabbix
EOF


sudo cat >> /etc/zabbix/web/zabbix.conf.php<<EOF
<?php
// Zabbix GUI configuration file.
global \$DB;

\$DB['TYPE']     = 'MYSQL';
\$DB['SERVER']   = 'localhost';
\$DB['PORT']     = '0';
\$DB['DATABASE'] = 'zabbix';
\$DB['USER']     = 'zabbix';
\$DB['PASSWORD'] = 'zabbix';

// Schema name. Used for IBM DB2 and PostgreSQL.
\$DB['SCHEMA'] = '';

\$ZBX_SERVER      = 'localhost';
\$ZBX_SERVER_PORT = '10051';
\$ZBX_SERVER_NAME = '';

\$IMAGE_FORMAT_DEFAULT = IMAGE_FORMAT_PNG;
EOF

sudo chmod 777 /etc/zabbix/web/zabbix.conf.php

sudo systemctl start zabbix-server httpd zabbix-agent rh-php72-php-fpm
sudo systemctl enable zabbix-server httpd zabbix-agent rh-php72-php-fpm

