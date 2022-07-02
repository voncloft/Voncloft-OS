#!/bin/bash

OLD_IP=$(cat /etc/VPN_TO_CHECK.txt)

NEW_IP=$(ifconfig tun0 | grep 'inet addr:' | cut -d: -f2| cut -d' ' -f1)

if [[ ! $NEW_IP == $OLD_IP ]]; then
	echo "IP CHANGED"
        ip rule flush table deluge
        ip rule add from all fwmark 0x1 lookup deluge
        ip route add default via $NEW_IP table deluge
        #sed -i -e "s/$OLD_IP/$NEW_IP/g" /home/deluge/.config/deluge/core.conf
        #chown deluge:deluge /home/deluge/.config/deluge/core.conf
        #/etc/init.d/deluged restart
	killall deluged
	/usr/bin/deluged --pidfile /home/deluge/deluged.pid -L debug -l /home/deluge/deluged.log --user deluge --group deluge --config /home/deluge/.config/deluge -i $NEW_IP

else
	echo "NO CHANGE YOU ARE PROTECTED"
fi

echo $NEW_IP > /etc/VPN_TO_CHECK.txt
