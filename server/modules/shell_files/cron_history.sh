#!/bin/bash

log=/var/cron/log
N="<..root"

catCmd=`which cat`
awkCmd=`which awk`
sedCmd=`which sed`
tailCmd=`which tail`

result=$($catCmd $log | \
         $awkCmd '{ row[NR]=$0
           if ( row[NR] ~ /'${N}'/ ) {
              #print " DBG: " row[NR-2] " 2: " row[NR-1] " 1: " row[NR];
              print "{ "row[NR-2]", "row[NR-1]", "row[NR]" },";
              #print row[NR-2]", "row[NR-1]", "row[NR];
           }
         }' | sed 's/>..CMD:/"CMD":/g;s/>..root/"start":/g;s/<..root/"end":/g')
#sed 's/>..CMD:/"CMD":/g;s/[><]..root //g')

echo "${result%?}" # multi-line
# echo [ ${result%?} ] # single line
# echo "[ { " ${result%?} " } ]" # single line
