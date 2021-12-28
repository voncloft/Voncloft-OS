#!/bin/sh
/usr/sbin/postfix upgrade-configuration
rm /etc/postfix/main.cf.spkgnew
rm /etc/postfix/master.cf.spkgnew
rm /etc/postfi/saslpasswd.spkgnew
