#!/bin/bash

errmsg="[ { \"error\": \"`basename $0`\" } ]"
awkCmd=`which awk`
dfCmd=`which df`
grepCmd=`which grep`
swapCmd=`which swap`

$swapCmds -l > /dev/null 2>&1
if [ "$?" = "0" ] ; then
   result=$($swapCmd -sh | $awkCmd '{print "{ \"allocated\": \""$2"\", \"reserved\": \""$5"\", \"size\": \""$3"\", \"used\": \""$8"\", \"available\": \""$10"\" } "}')
else
   result=$($dfCmd -h | $grepCmd "/tmp$" | $awkCmd '{print "{ \"size\": \""$2"\", \"used\": \""$3"\", \"available\": \""$4"\" } "}')
fi

if [ -z "$result" ] ; then
   echo $errmsg
else
   echo [ ${result%?} ]
fi
