#!/bin/sh
groupadd -g 20 named &&
useradd -c "BIND Owner" -g named -s /bin/false -u 20 named &&
install -d -m770 -o named -g named /srv/named

mkdir -p /srv/named &&
cd       /srv/named &&
mkdir -p dev etc/named/{slave,pz} usr/lib/engines var/run/named &&
mknod /srv/named/dev/null c 1 3 &&
mknod /srv/named/dev/urandom c 1 9 &&
chmod 666 /srv/named/dev/{null,urandom} &&
cp /etc/localtime etc

rndc-confgen -a -b 512 -t /srv/named

cp /etc/resolv.conf /etc/resolv.conf.bak &&
cat > /etc/resolv.conf << "EOF"
search voncloft.dnsfor.me
nameserver 127.0.0.1
EOF

chown -R named:named /srv/named

scratch install -y bind-boot

/etc/rc.d/init.d/bind start
