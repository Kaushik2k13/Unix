#!/bin/bash

if [ $# -le 0 ]; then
	echo "Usage: $0 [-qw]"
	echo
fi

limit=0

log_c()
{

logfile=$(<$1)
ip=$(echo $logfile |grep -Eo '[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}') 
ip="`echo "$ip" | sort | uniq -c | sort -n -r |awk '{print $2"  "$1 }'`"
a=0

if [ $2 != $a ];
then
	echo "$ip" | head -n $2
else
	echo "$ip"
fi

}

log_2()
{
	logfile=$(<$1)
	ip_2=$(echo "$logfile" | grep "HTTP\/[0-1]\.[0-9]\" [2][0-9][0-9]" | grep -Eo '[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}')
	ip="`echo "$ip_2" | sort | uniq -c | sort -n -r | awk '{print $2"  "$1}'`"
	echo "$ip" | head -n $limit
"HTTP\/[0-1]\.[0-9]\" [2][0-9][0-9]"
	a=0

	if [ $limit != $a ];
	then
		echo "$ip" | head -n $2
	else
		echo "$ip"
	fi
}

log_r()
{
	logfile=$(<$1)
	result_code="`echo "$logfile"| awk '{print $9}' | sort |uniq -c| sort -n -r`"
	result_code=$(echo "$result_code"| grep "[2-4][0][0-4]" | grep -Eo "[2-4][0][0-4]")
      	for code in $result_code;
	do
		echo $code
		s_code=$(echo "$logfile" | grep "HTTP\/[0-1]\.[0-9]\" $code" | awk '{print $1,$9}')
	        result="`echo "$s_code"| sort | uniq -c | sort -nr |awk '{print $3"  "$2}'`" 
		a=0

		if [ $limit != $a ]
		then
			echo "$result" | head -n $limit
		else
			echo "$result"
		fi
	done

}

log_F()
{
	logfile=$(<$1)
	status_code=$(echo "$logfile"|grep  "HTTP\/[0-1]\.[0-9]\" [4-5][0-9][0-9]") 
	status_code=$(echo "$status_code" | awk '{print $9}')
	status_code="`echo "$status_code" | sort| uniq -c| sort -nr | awk '{print $2}'`"
	for code in $status_code;
	do
		echo $code
		s_code=$(echo "$logfile" | grep "HTTP\/[0-1]\.[0-9]\" $code" | awk '{print $1,$9}')
		result=$(echo "$s_code"| sort|uniq -c | sort -n -r| awk '{print $3"  " $2}')
		#echo "$result" | head -n $limit

		if [ $limit != 0 ];
		then
			echo "$result" | head -n $limit
		else
			echo "$result"
		fi


	done		        
}


log_t()
{
	logfile=$(<$1)
	capIPByte=$(echo "$logfile" | awk '{print $1,$10}'| sort -k 1,1)
	capIPByte="`echo "$capIPByte" |awk '{print $1,$2}'|grep -v "-"`"
	capIP=$(echo "$capIPByte" |awk '{print $1}'| sort | uniq |sort -nr| awk '{print $1}')
	declare -A IParray
	for IP in ${capIP[@]};
	do
		sum=0
		byte=$(echo "$capIPByte"|grep "$IP"|awk '{print $2}' )
	
		for value in ${byte[@]};
		do
			sum=$(expr $sum + $value)
		done
		IParray[$IP]=$sum 
	done
	
	if [ $limit != 0 ];
	then
		for IP in ${!IParray[@]}; 
		do
			echo -e "$IP  ${IParray[$IP]} bytes"
		done | sort -k2 -r -n | head -n $limit
	else
		for IP in ${!IParray[@]}; 
		do
			echo -e "$IP  ${IParray[$IP]} bytes"
		done | sort -k2 -r -n
	fi
	 

}


maxlimitinst=2


if [ $1 = "-n" ] 
then
	limit=$2
	shift 2
fi

if [ $# -gt $maxlimitinst ]
then
	echo "Max arguemnts reached"
else
	case $1 in
		-c)
			log_c $2 $limit
			;;
		-2)
			log_2 $2
			;;
		-r)
			log_r $2
			;;
		-F)
			log_F $2
			;;
		-t)
			log_t $2
			;;

		-?)
			echo "U should give parameter"
			;;
	esac
fi	
