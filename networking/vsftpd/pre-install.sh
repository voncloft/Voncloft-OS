#!/bin/sh
install -v -d -m 0755 /usr/share/vsftpd/empty &&
install -v -d -m 0755 /home/ftp
groupadd -g 47 vsftpd
groupadd -g 45 ftp
useradd -c "vsftpd User"  -d /dev/null -g vsftpd -s /bin/false -u 47 vsftpd
useradd -c anonymous_user -d /home/ftp -g ftp    -s /bin/false -u 45 ftp
