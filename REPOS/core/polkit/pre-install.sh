#!/bin/sh
groupadd -fg 27 polkitd
useradd -c "PolicyKit Daemon Owner" -d /etc/polkit-1 -u 27 -g polkitd -s /bin/false polkitd
