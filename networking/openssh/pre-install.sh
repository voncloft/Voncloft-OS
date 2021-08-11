#!/bin/sh
groupadd -g 50 sshd
useradd -c "sshd PrivSep" -d /var/lib/sshd -g sshd -s /bin/false -u 50 sshd
