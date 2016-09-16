#!/bin/bash
# 1: uptime
# 2 wip: kstat -p 'unix:0:system_misc:avenrun*'

result=$(/bin/uptime | awk '{print "{ \"1_min_avg\": " $(NF-2) ", \"5_min_avg\": " $(NF-1) ", \"15_min_avg\": " $(NF-0) " }," }' | /bin/sed 's/,,/,/g')

#result=$(/bin/kstat -p 'unix:0:system_misc:avenrun*' | /bin/awk -F: '{print $4}' | /bin/awk 'BEGIN {print "{"} {print "\"" $1 "\": " $2 ""} END {print "}"} ')

echo ${result%?}
