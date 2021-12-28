#!/bin/sh
groupadd -fg 84 avahi &&
useradd -c "Avahi Daemon Owner" -d /var/run/avahi-daemon -u 84 \
	-g avahi -s /bin/false avahi
groupadd -fg 86 netdev

