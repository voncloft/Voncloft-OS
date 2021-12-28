#!/bin/sh
rm /etc/postfix/main.cf.spkgnew
rm /etc/postfix/master.cf.spkgnew
rm /etc/postfi/saslpasswd.spkgnew

scratch install -y postfix-boot
