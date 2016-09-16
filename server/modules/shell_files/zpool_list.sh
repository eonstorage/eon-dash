#!/bin/bash

errmsg="[ { \"error\": \"`basename $0`\" } ]"
zpoolCmd=`which zpool`
awkCmd=`which awk`

result=$($zpoolCmd list | \
         $awkCmd 'NR>1 {print "{ \"name\": \"" $1 "\", \"size\": \"" $2 "\", \"alloc\": \"" $3 "\", \"free\": \"" $4 "\", \"capacity\": \"" $5 "\", \"dedup\": \"" $6 "\", \"health\": \"" $7 "\", \"altroot\": \"" $8 "\" },"}')

if [ -z "$result" ] ; then
   echo $errmsg
else
   # echo "[ ${result%?} ]" # multi-line
   echo [ ${result%?} ] # single line
fi
