#!/bin/bash

log=/var/cron/log
N="CMD"

result=$(cat $log | /bin/sed "/CMD/,/<..root/!d" | sed '$!N;N;s/\n/ /g')

echo "[ ${result%?} ]"
