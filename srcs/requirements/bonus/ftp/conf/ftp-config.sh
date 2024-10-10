#!/bin/bash

cat /ftp.conf >> /etc/vsftpd.conf

adduser "$FTP_USER" --disabled-password

sleep 1

echo "$FTP_USER":"$FTP_PASSWD" | /usr/sbin/chpasswd

chown -R "$FTP_USER" /var/www/web/

vsftpd /etc/vsftpd.conf
