#!/bin/bash
# list biggest processes by memory
N="total"
pmapCmd=`which pmap`
awkCmd=`which awk`
sedCmd=`which sed`

result=$($pmapCmd -x /proc/* 2> /dev/null | egrep "[0-9]:|total Kb" | \
         $awkCmd '{ row[NR]=$0
           if ( row[NR] ~ /'${N}'/ ) { print row[NR-1]" "row[NR]; }
         }' | $sedCmd 's/total Kb//g;s/       -$//g' | sort -k3,5nr | \
         $awkCmd '{print "{ \"pid\": " $1 ", \"proc\": \"" $2 "\", \"mem Kb\": " $(NF-2) ", \"rss Kb\": " $(NF-1) ", \"Anon Kb\": " $(NF-0) " },"}')

echo "${result%?}" # multi-line
# echo ${result%?} # single line
# echo "[" ${result%?} "]" # single line
