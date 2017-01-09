
#machines=`nmap -sn 10.252.65.* | awk '/Nmap scan report/{print $5}'`;
#machines="zahn1 zahn2 zahn3 zahn4 zahn5 zahn6 zahn7 zahn8 zahn8 zahn10 zahn11 tuki1 tuki2 tuki3 tuki4 tuki5 tuki6 ibm01 ibm02 aeryn1 aeryn2 aeryn3 aeryn4 aeryn5"
#for i in $machines; do 
	#ssh -q -tt -o ConnectTimeout=5 $i ~/bin/bdname.sh;
#PDSH_SSH_ARGS_APPEND="-q -tt" /net/loki/share/bin/pdsh -t 3 -w zahn[1-10] ~/bin/bdname.sh 2>/dev/null | /net/loki/share/bin/dshbak -c
PDSH_SSH_ARGS_APPEND="-q -tt " /net/loki/share/bin/pdsh -t 2 -w zahn[1-6],tuki[1-6],aeryn[2-5],ibm[01-02] ~/bin/bdname.sh 2>/dev/null | /net/loki/share/bin/dshbak -c
#done;

