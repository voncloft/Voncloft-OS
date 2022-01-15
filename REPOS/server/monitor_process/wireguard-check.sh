devices=$(ls /sys/class/net)
flag=0
for word in $devices
do
	if [[ $word == "wg0" ]];then
		flag=$(( flag + 1))
	fi
done
if [[ $flag -eq 1 ]];then
	echo -e ${GREEN}"Wireguard is running normally."${NC}
else
	mailme $email "Wireguard is not running - restarting"
	echo -e ${RED}"Wireguard is not running - restarting"${NC}
	/etc/init.d/wireguard start
fi
