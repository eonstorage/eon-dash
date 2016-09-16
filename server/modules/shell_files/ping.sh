#!/bin/bash
# single line json: [{  }]

# get absolute path to config file
SCRIPTPATH=`dirname $0`
CONFIG_PATH=$SCRIPTPATH"/../config/ping_hosts"

catCmd=`which cat`
pingCmd=`which ping`
awkCmd=`which awk`
sedCmd=`which sed`
numOfLinesInConfig=`$sedCmd -n '$=' $CONFIG_PATH`
result='['

$catCmd $CONFIG_PATH | while read output
do
# round-trip (ms)  min/avg/max/stddev = 18.850/19.238/19.627/0.549
# $6 = avg
   singlePing=$($pingCmd -s $output 16 2 | \
   $awkCmd -F/ 'BEGIN { endLine="}, " } /^round-trip/ { if ('$numOfLinesInConfig'==1){endLine="}"} print "{" "\"host\": \"'$output'\", \"ping(avg ms)\": \""$6"\"" endLine }')

   numOfLinesInConfig=$(($numOfLinesInConfig-1))
   result=$result$singlePing
   if [ $numOfLinesInConfig -eq 0 ] ; then
      echo $result"]"
   fi
done
