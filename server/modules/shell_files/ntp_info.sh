#!/bin/bash

errmsg="[ { \"error\": \"`basename $0`\" } ]"
awkCmd=`which awk`
grepCmd=`which grep`
ntpqCmd=`which ntpq`

result=$($ntpqCmd -pn | $awkCmd 'NR>2 {print "{ \"remote\": \""$1"\", \"refid\": \""$2"\", \"stratum\": \""$3"\", \"type\": \""$4"\", \"when\": \""$5"\", \"poll\": \""$6"\", \"reach\": \""$7"\", \"delay\": \""$8"\" },"}')

if [ -z "$result" ] ; then
   echo $errmsg
else
   # echo "[ ${result%?} ]" # multi-line
   echo [ ${result%?} ] # single line
fi
