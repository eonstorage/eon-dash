#!/bin/bash

awkCmd=/usr/bin/awk
headCmd=/usr/bin/head
psCmd=/usr/bin/ps
sortCmd=/usr/bin/sort

# sorted by pcpu(3) rss(4) vsz(5)
result=$($psCmd -ao pid,user,pcpu,rss,vsz,args | $sortCmd -r -k3,3 -k2,4 -k3,5 | $headCmd -n 16 | \
         $awkCmd 'BEGIN{OFS=":"} NR>1 {print "{ \"pid\": " $1 ", \"user\": \"" $2 "\", \"cpu%\": " $3 ", \"rss\": " $4 ", \"vsz\": " $5 ", \"cmd\": \"" $6 "\" }," }')

echo "[" ${result%?} "]"
