#!/bin/sh
chmod -v 755 /usr/bin/run-parts
install -vdm754 /etc/cron.{hourly,daily,weekly,monthly}
cat > /var/spool/fcron/systab.orig << "EOF"
&bootrun 01 * * * * root run-parts /etc/cron.hourly
&bootrun 02 4 * * * root run-parts /etc/cron.daily
&bootrun 22 4 * * 0 root run-parts /etc/cron.weekly
&bootrun 42 4 1 * * root run-parts /etc/cron.monthly
EOF
scratch install -y fcron-boot
/etc/rc.d/init.d/fcron start
fcrontab -z -u systab
rm /var/spool/fcron/systab.orig.spkgnew

/etc/init.d/fcron start
