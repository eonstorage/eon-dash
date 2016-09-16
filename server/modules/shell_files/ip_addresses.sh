#!/bin/bash

for int in `dladm show-phys -p -o link`
do
MTU=`dladm show-link -p -o mtu $int`
mac=`dladm show-phys -m -p -o address $int`
neg=`dladm show-ether -p -o auto $int`

phys=`dladm show-phys -p -o link,media,state,speed,duplex`
dev=`echo $phys | awk -F: '{print $1}'`
media=`echo $phys | awk -F: '{print $2}'`
state=`echo $phys | awk -F: '{print $3}'`
speed=`echo $phys | awk -F: '{print $4}'`
duplex=`echo $phys | awk -F: '{print $5}'`

addr=`ipadm show-addr -p -o ,type,state,addr`

cat << _EOF_
[ { "int": "$dev", "media": "$media", "mac": "${mac}", "MTU": "${MTU}", "speed": "$speed", "duplex": "$duplex", "Auto": "${neg}", "state": "$state" } ]
_EOF_

done
