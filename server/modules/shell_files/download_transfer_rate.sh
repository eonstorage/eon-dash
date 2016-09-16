#!/bin/bash

dev=`ifconfig -a | grep "flags=" | awk -F: '{print $1}' | grep -v lo0`
pos=$(( ${#dev[*]} - 1 ))
last=${dev[$pos]}

getrx() { kstat -p "*:*:$1:rbytes64" | awk '{print $2}' ; }

json_output="{"

for interface in "${dev}" 
do
  basename=$(basename "$interface")

  # find the number of bytes transfered for this interface
  in1=$(getrx $interface)

  # wait a second
  sleep 1

  # check same interface again
  in2=$(getrx $interface)

  # get the difference (transfer rate)
  in_bytes=$((in2 - in1))

  # convert transfer rate to KB
  in_kbytes=`echo "scale=3 ; $in_bytes / 1024" | /bin/bc`

  # convert transfer rate to KB
  json_output="$json_output \"$basename\": $in_kbytes"

  # if it is not the last line
  if [[ ! $interface == $last ]]
  then
  # add a comma to the line (JSON formatting)
  json_output="$json_output,"
  fi 
done

# close the JSON object & print to screen
echo "$json_output }"
