#!/bin/bash

errmsg="[ { \"error\": \"`basename $0`\" } ]"
pkginCmd=`which pkgin`
awkCmd=`which awk`

result=$($pkginCmd ls | \
         $awkCmd '{print "{ \"binary\": \""$1"\", \"description\": \""substr($0, index($0,$2))"\" },"}')

# echo "[ ${result%?} ]" # multi-line
echo [ ${result%?} ] # single line
