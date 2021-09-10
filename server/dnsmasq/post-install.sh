#!/bin/sh
scratch install -y dnsmasq-boot
/etc/init.d/dhcpd start
