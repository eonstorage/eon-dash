#!/bin/bash

errmsg="[ { \"error\": \"`basename $0`\" } ]"
arpCmd=`which arp`
awkCmd=`which awk`

# IPv4 filter if Flags field is null
result=$($arpCmd -na | \
         $awkCmd 'NR>3 {if (NF == 4) {FLAG="";} else {FLAG=$4;} print "{ \"address\": \"" $2 "\", \"hw_type\": \"" $1 "\", \"hw_address\": \"" $NF "\", \"flags\": \"" FLAG "\", \"mask\": \"" $3 "\" },"}')

if [ -z "$result" ] ; then
   echo $errmsg
else
   echo [ ${result%?} ] # single line
   #echo "[ ${result%?} ]" # multi-line
fi
