#!/bin/sh
install -v -m700 -d $PKG/var/lib/sshd
chown -v root:sys $PKG/var/lib/sshd
groupadd -g 50 sshd
useradd  -c 'sshd PrivSep' \
-d /var/lib/sshd  \
-g sshd           \
-s /bin/false     \
-u 50 sshd
