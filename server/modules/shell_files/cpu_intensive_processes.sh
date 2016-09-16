#!/bin/bash
# sort pcpu(3) rss(4) vsz(5)
result=$(/bin/ps -aeo pid,user,pcpu,rss,vsz,comm | \
         /bin/sort -r -k3,3 -k2,4 -k3,5 | /bin/head -n 16 | \
         /usr/bin/awk 'BEGIN{OFS=":"} NR>1 {print "{ \"pid\": " $1 \
							", \"user\": \"" $2 "\"" \
							", \"cpu%\": " $3 \
							", \"rss\": " $4 \
							", \"vsz\": " $5 \
							", \"cmd\": \"" $6 "\"" " }," }')

echo "[" ${result%?} "]"
