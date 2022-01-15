devices=$(ls /sys/class/net)
flag=0
for word in $devices
do
	if [[ $word == "wg0" ]];then
		flag=$(( flag + 1))
	fi
done
if [[ $flag -eq 1 ]];then
	echo -e ${GREEN}"wireguard is running normally."${NC}
else
	mailme $email "wireguard is not running - restarting"
	echo -e ${RED}"wireguard is not running - restarting"${NC}
	/etc/init.d/wireguard start
fi
