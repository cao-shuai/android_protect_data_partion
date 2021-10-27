#!/system/bin/sh
datamountedcheck()
{
	while [[ 1 ]]; do
		#echo "check data partion can mounted..............." > /dev/console;
		sleep 5
		datamounted=$(df -h |grep -w "/data" |wc -l)
		#echo "board data partion is mounted: "$datamounted > /dev/console;
		if [[ $datamounted -lt '1' ]]; then
			#statements
			boarduptimemin=$(uptime |awk '{print $3}');
			echo "board uptime since AC used(min) :"${boarduptimemin} > /dev/console;
			if [[ $boarduptimemin -gt '2' ]]; then
				echo "data partion error, !!! will force recovery....." > /dev/console;
				reboot recovery
			fi
		else
			echo "data partion mounted success and wait 120S will check data partion size..............." > /dev/console;
			sleep 120
			break
		fi
	done
}

datasizecheck()
{
	while [[ 1 ]]; do
		#echo "check data partion size more than 50M..............." > /dev/console;
		dataAvail=$(df -h |grep -w "/data" |awk '{print $4}')
		#echo "board data partion spec Avail is: "$dataAvail  > /dev/console;
		dataMORG=${dataAvail:0-1:1}
		#echo "dataMORG is: "$dataMORG > /dev/console;
		if [[ "$dataMORG" == "M" ]]; then
			dataVale=${dataAvail%?}
			#echo "dataAvail is: "$dataVale > /dev/console;
			if [[ $(echo "$dataVale <= 50"|bc) = 1 ]]; then
				#statements
				echo "warring data spec less than 50M ,will reboot recovery....." > /dev/console;
				reboot recovery
			elif [[ $(echo "$dataVale <= 200"|bc) = 1 ]]; then
				#echo "check data partion size sleep 5S..............." > /dev/console;
				sleep 5
			else
				#echo "check data partion size sleep 10S..............." > /dev/console;
				sleep 10
			fi
		elif [[ "$dataMORG" == "G" ]]; then
			#echo "check data partion size sleep 60S..............." > /dev/console;
			sleep 60
		fi
	done
}

echo "protect for our board thread start..............." > /dev/console;
datamountedcheck
datasizecheck
