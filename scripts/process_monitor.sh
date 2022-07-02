#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'
while IFS=, read -ra items; do
    for item in "${items[@]}"; do
		if ps aux | grep -v 'grep' | grep -q $item;
          	then
			if [ $item == "psad" ] || [ $item == "openvpn" ] || [ $item == "vsftpd" ];
			then
				echo -e ${YELLOW}"$item is manually monitored - running normally."${NC}
			else
				echo -e ${GREEN}"$item is running normally."${NC} 
			fi
          	else
			#mailme 2606159678@vtext.com "$item is not running"
			if [ $item == "dnsmasq" ];
			then
				mailme 2606159678@vtext.com "$item is not running"
				/etc/init.d/dhcpd start
			elif [ $item == "smbd" ];
			then
				mailme 2606159678#vtext.com "$item is not running"
				/etc/init.d/samba start
			elif [ $item == "psad" ] || [ $item == "openvpn" ] || [ $item == "vsftpd" ];
			then
				echo -e ${YELLOW}"$item is manually monitored - brought down for maintenance."${NC}
			else
				mailme 2606159678@vtext.com "$item is not running"
				echo -e ${RED}"$item is not running"${NC}
          			/etc/init.d/$item start
			fi
          	fi
    done
done <<< "deluge-web,dnsmasq,hostapd,httpd,lxdm,mysql,noip2,openvpn,php-fpm,postfix,psad,smbd,sshd,subsonic,vsftpd"
#done <<< "deluged,deluge-web,dnsmasq,hostapd,lxdm,noip2,openvpn,php-fpm,psad,smbd,sshd,subsonic,vsftpd"

source /media/Scripts/test-wg.sh
#source /usr/bin/check_tun_ip
source /media/Scripts/plex.sh
