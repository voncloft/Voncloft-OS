#!/bin/sh
groupadd -g 18 messagebus
useradd -c "D-Bus Message Daemon User" -d /var/run/dbus -u 18 -g messagebus -s /bin/false messagebus
