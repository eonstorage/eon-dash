#!/bin/bash

result=$(/bin/netstat -na | \
         /bin/egrep -v "^(TCP|UDP|   Local|Active|Address|---|$)" | \
         /bin/sort | /bin/uniq -u | \
         /bin/awk '{
           if (NF > 5) {
              print "{ \"local\": \"" $1 "\", \"connection\": \"" $2 "\", \"state\": \"" $7 "\" },"
           } else if (NF == 2) {
              print "{ \"local\": \"" $1 "\", \"connection\": \"" "\", \"state\": \"" $2 "\" },"
           } else if (NF == 5) {
              print "{ \"local\": \"" $1 "\", \"connection\": \"" $3 "\", \"state\": \"" $5 "\" },"
           }
         }')

echo "[" ${result%?} "]"
