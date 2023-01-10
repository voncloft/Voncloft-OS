#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

email=$(cat /etc/scratchpkg.email)
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
			if [ $item == "dnsmasq" ];
			then
				mailme $email "$item is not running"
				/etc/init.d/dhcpd start
			elif [ $item == "smbd" ];
			then
				mailme $email "$item is not running"
				/etc/init.d/samba start
			elif [ $item == "psad" ] || [ $item == "openvpn" ] || [ $item == "vsftpd" ];
			then
				echo -e ${YELLOW}"$item is manually monitored - brought down for maintenance."${NC}
			else
				mailme $email "$item is not running"
				echo -e ${RED}"$item is not running"${NC}
          			/etc/init.d/$item start
			fi
          	fi
    done
done <<< "deluged,deluge-web,dnsmasq,hostapd,httpd,lxdm,mysql,noip2,openvpn,php-fpm,postfix,psad,smbd,sshd,sshguard,subsonic,vsftpd"
source /usr/bin/wireguard-check.sh
