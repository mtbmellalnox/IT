export PATH=$PATH:/sbin:/usr/sbin
hn=`hostname`
IAM=`whoami`; #echo "I am:$IAM"
IPcmd=`which ip`; #echo "IPcmd:$IPcmd"
ETHTOOLcmd=`which ethtool`; #echo "ETHTOOLcmd:$ETHTOOLcmd"
LSPCIcmd=`which lspci`; #echo "LSPCIcmd:$LSPCIcmd"
IBSTATcmd=`which ibstat >/dev/null 2>&1`
 
release=`find /etc -maxdepth 1 ! -readable -prune -o -name *release* -type f -exec cat {} \; | grep release | head -n1`
user=`grep user /etc/motd | sed -e 's|_user_ ||'`
echo "user:$user"
start_date=`grep date /etc/motd | sed -e 's|_lock_date_ ||'`
echo "start_date:$start_date"
case=`grep case /etc/motd | sed -e 's|_sf_case_ ||'`
echo "case:$case"
echo "Release:$release"

product_name=`cat /sys/devices/virtual/dmi/id/product_name  2>/dev/null`
echo "product_name:$product_name"
bios_vendor=`cat /sys/devices/virtual/dmi/id/bios_vendor  2>/dev/null`
bios_name=`cat /sys/devices/virtual/dmi/id/bios_name 2>/dev/null` 
chassis_vendor=`cat /sys/devices/virtual/dmi/id/chassis_vendor 2>/dev/null`
echo "chassis_vendor:$chassis_vendor"
bios_version=`cat /sys/devices/virtual/dmi/id/bios_version 2>/dev/null`
echo "bios_vendor:$bios_vendor bios_name:$bios_name bios_version:$bios_version"

version=""
if [ -z "$version" ] && [ -e /etc/os-release ]; then
	version=`cat /etc/os-release | sed '$!d'`
fi
if [ -z "$version" ] && [ -e /etc/centos-release ]; then
	version=`cat /etc/centos-release | sed '$!d'`
fi
echo "Version:$version"
kern=`uname -r`
echo "Kernel:$kern"

#-----  are we using sysv upstart or systemd init? -----
initsys=`ps -p 1 | sed -n '2p' | awk '{print $4}'`
echo "INIT:$initsys"
# stat /proc/1/exe | head -n2

brd_id=`ibv_devinfo | grep board_id | awk '{print $2}'`
echo "board_id:$brd_id"
#if [[ -e /etc/init.d/opensmd ]]; then smdstatus=`/etc/init.d/opensmd status 2>/dev/null` else smdstatus="Not Installed" fi
#echo "SMD:$smdstatus"
if [[ -e /etc/init.d/ufmd ]]; then ufmstatus=`/etc/init.d/ufmd status | sed '1d' 2>/dev/null`; else ufmstatus="Not Installed";fi
echo "UFM:$ufmstatus"
if [[ ! -z $IBSTATcmd ]]; then
	Lids=`$IBSTATcmd | grep lid`
	echo "Lids:$Lids"
fi

#if [[ -e /bin/ibdev2netdev ]]; then /bin/ibdev2netdev; fi
#if [[ -e /sbin/connectx_port_config ]]; then /sbin/connectx_port_config; fi

#user=`grep Hello /etc/motd | sed -e 's/Hello //'`
#echo "-----USER:$user -----"

$LSPCIcmd | grep Mellanox

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
		
		if [[ ! -z $ETHTOOLcmd ]]; then
			drv=`$ETHTOOLcmd -i $name | grep "^version" | sed -e 's|^version:||'`
			fw=`$ETHTOOLcmd -i $name | grep "^firmware" | awk '{print $2}'`
		fi
		echo "dev:${name} mac:$mac mtu:$mtu state:$state spd:$speed drv:${drv} fw:${fw}"
	#fi
done

#$LSPCIcmd | grep Ethernet


