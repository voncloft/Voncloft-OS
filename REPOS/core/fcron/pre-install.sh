#!/bin/sh
 mkdir -pv  /etc/pam.d
cat >> /etc/syslog.conf << "EOF"
# Begin fcron addition to /etc/syslog.conf

cron.* -/var/log/cron.log

# End fcron addition
EOF

/etc/rc.d/init.d/sysklogd reload

groupadd -g 22 fcron &&
useradd -d /dev/null -c "Fcron User" -g fcron -s /bin/false -u 22 fcron
