#!/bin/bash

errmsg="[ { \"error\": \"`basename $0`\" } ]"

result=$(prstat 1 1 | egrep -v "^(   PID|Total|$)" | \
         awk '{print "{"}\
              {print "\"appName\":\"" $10 "\","} \
              {print "\"id\":\"" $6 "\","} \
              {print "\"mode\":\"" $5 "\","} \
              {print "\"pid\":\"" $1 "\","}\
              {print "\"status\":\"" $5 "\","}\
              #{print "\"restart\":\"" $12 "\","}\
              {print "\"uptime\":\"" $8 "\","}\
              {print "\"memory\":\"" $3 "\","}\
              {print "\"rss\":\"" $4 "\""}\
              {print "},"}')

if [ -z "$result" ] ; then
   echo $errmsg
else
   # echo "[ ${result%?} ]" # multi-line
   echo "[" ${result%?} "]" # single line
fi
