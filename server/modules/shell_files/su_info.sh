#!/bin/bash

errmsg="[ { \"error\": \"`basename $0`\" } ]"
tailCmd=`which tail`
awkCmd=`which awk`

result=$($tailCmd -20 /var/adm/sulog | \
         $awkCmd '{print "{ \"Date\": \"" $2 "\", \"Time\": \"" $3 "\", \"Status\": \"" $4 "\", \"tty\": \"" $5 "\", \"User\": \"" $6 "\" },"}')

if [ -z "$result" ] ; then
   echo $errmsg
else
   # echo "[ ${result%?} ]" # multi-line
   echo [ ${result%?} ] # single line
fi
