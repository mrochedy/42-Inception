#!/bin/bash

cat /ftp.conf >> /etc/vsftpd.conf

adduser "$FTP_USER" --disabled-password

echo "$FTP_USER":"$FTP_PASSWD" | /usr/sbin/chpasswd

chown -R "$FTP_USER":"$FTP_USER" /var/www/wordpress

vsftpd /etc/vsftpd.conf
