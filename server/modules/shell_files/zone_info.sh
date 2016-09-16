#!/bin/bash
# cpu memory info for zones
N="ZONEID"
prstatCmd=`which prstat`
awkCmd=`which awk`
egrepCmd=`which egrep`

result=$($prstatCmd -Z -c -n 1,99999 5 1 | $egrepCmd -v "^(Please|Total)" | \
         $awkCmd 'NR>3 {print "{ \"zoneid\": \"" $1 "\", \"nproc\": \"" $2 "\", \"swap\": \"" $3 "\", \"rss\": \"" $4 "\", \"memory\": \"" $5 "\", \"time\": \"" $6 "\", \"cpu\": \"" $7 "\", \"zone\": \"" $8 "\" }," }')

echo "${result%?}" # multi-line
# echo [ ${result%?} ] # single line
# echo "[ { " ${result%?} " } ]" # single line
