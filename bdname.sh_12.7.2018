hn=`hostname`
kern=`uname -r`
release=`find /etc ! -readable -prune -o -name *release* -type f -exec cat {} \; | grep release | head -n1`
user=`grep user /etc/motd | sed -e 's|_user_ ||'`
echo "user:$user"
start_date=`grep date /etc/motd | sed -e 's|_lock_date_ ||'`
echo "start_date:$start_date"
case=`grep case /etc/motd | sed -e 's|_sf_case_ ||'`
echo "case:$case"
echo "Release:$release"
echo "Kernel:$kern"
#if [[ -e /etc/init.d/opensmd ]]; then smdstatus=`/etc/init.d/opensmd status 2>/dev/null` else smdstatus="Not Installed" fi
#echo "SMD:$smdstatus"
if [[ -e /etc/init.d/ufmd ]]; then ufmstatus=`/etc/init.d/ufmd status | sed '1d' 2>/dev/null`; else ufmstatus="Not Installed";fi
echo "UFM:$ufmstatus"
#if [[ -e /bin/ibdev2netdev ]]; then /bin/ibdev2netdev; fi
#if [[ -e /sbin/connectx_port_config ]]; then /sbin/connectx_port_config; fi

#user=`grep Hello /etc/motd | sed -e 's/Hello //'`
#echo "-----USER:$user -----"

if [[ -e /usr/sbin/lspci ]]; then
	LSPCI=/usr/sbin/lspci
elif [[ -e /sbin/lspci ]]; then
	LSPCI=/sbin/lspci
fi
$LSPCI | grep Mellanox

#/sbin/ip link ls  | grep -v lo | awk -F ':' '/^[[:digit:]]/ {print $2}' | while read -r name; do

# remove lo any.any bond
for i in `ls /sys/class/net`; do echo $i | grep -v "\.\|lo\|bond"; done | while read -r name; do

#sudo biosdevname -d | while read -r line; do
#	if [ 1 -eq 0 ];then
#		if [[ $line =~ "OS device" ]]; then 
#			state="newquery";
#		fi

#		if [[ $state == "newquery" ]]; then
#			case "$line" in
#				"Kernel name:"*)	name="${line#*: }" ;;
#				"Permanent MAC:"*)	mac="${line#*: }" ;;
#				"Driver version:"*)	driver="${line#*: }" ;;
#				"Firmware version:"*)	fw="${line#*: }" ;;	
#				"Index in slot:"*)	state="stop" ;;
#				"Embedded Index:"*)	state="stop" ;;
#			esac
#		fi

#	fi

	#if [[ $state == "stop" ]]; then

		# only need the last fields...
		mac=`cat /sys/class/net/$name/address | sed  -e 's|^\([a-z0-9]\{2\}:\)\{14\}||g'`
		mtu=`cat /sys/class/net/$name/mtu`
		state=`cat /sys/class/net/$name/operstate`
		speed=`cat /sys/class/net/$name/speed 2>/dev/null`
		
		ETHTOOL=/usr/sbin/ethtool
		if [[ ! -z $ETHTOOL ]]; then
			drv=`$ETHTOOL -i $name | grep "^version" | sed -e 's|^version:||'`
			fw=`$ETHTOOL -i $name | grep "^firmware" | awk '{print $2}'`
		fi
		echo "dev:${name} mac:$mac mtu:$mtu state:$state spd:$speed drv:${drv} fw:${fw}"
	#fi
done

