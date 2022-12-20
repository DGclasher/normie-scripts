#!/bin/bash

if [ "$1" == "" ]
then
	echo "Usage: $0 IP Address"
	exit
fi

x=`curl http://ip-api.com/json/$1 -s`
status=`echo $x | jq ".status" -r`

if [ "$status" = "success" ]
then
	co=`echo $x | jq ".country" -r`
	cc=`echo $x | jq ".countryCode" -r`
	re=`echo $x | jq ".region" -r`
	rn=`echo $x | jq ".regionName" -r`
	ci=`echo $x | jq ".city" -r`
	zi=`echo $x | jq ".zip" -r`
	lat=`echo $x | jq ".lat" -r`
	lon=`echo $x | jq ".lon" -r`
	ti=`echo $x | jq ".timezone" -r`
	isp=`echo $x | jq ".isp" -r`
	ip=`echo $x | jq ".query" -r`

	echo -e "Country : $co\nCountry Code : $cc\nRegion : $re\nRegion Name : $rn\nCity : $ci\nZip Code : $zi\nLattitude : $lat\nLongitude : $lon\nTime Zone : $ti\nISP : $isp\nIP : $ip\n" | tee -a log
	echo "Information for IP $1 has been saved to log file"

else
	echo "The operation was unsuccessful"
fi

