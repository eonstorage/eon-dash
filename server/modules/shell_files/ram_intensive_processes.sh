#!/bin/bash

# cmd + args ($6+)
#result=$(/bin/ps -aeo pid,user,pmem,rss,vsz,args | \
#         /bin/sort -r -k3,3 -k2,4 -k3,5 | /bin/head -n 15 | \
#         /usr/bin/awk 'NR>1 {print "{ \"pid\": " $1 ", \"user\": \"" $2 "\", \"mem%\": " $3 ", \"rss\": " $4 ", \"vsz\": " $5 ", \"cmd\": \""substr($0, index($0,$6))"\" },"}')

# cmd - no args ($6 = comm)
result=$(/bin/ps -aeo pid,user,pmem,rss,vsz,comm | \
         /bin/sort -r -k3,3 -k2,4 -k3,5 | /bin/head -n 15 | \
         /usr/bin/awk 'NR>1 {print "{ \"pid\": " $1 ", \"user\": \"" $2 "\", \"mem%\": " $3 ", \"rss\": " $4 ", \"vsz\": " $5 ", \"cmd\": \"" $6 "\" },"}')

echo [ ${result%?} ]
