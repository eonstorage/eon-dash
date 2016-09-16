#!/bin/bash
# single line json: {  }
freeCmd=`which free`
awkCmd=`which awk`

if [ -x $freeCmd ] ; then
result=$($freeCmd -p | $awkCmd -F\; '$1 ~ /Mem/ {print "{ \"total\": \"" $2/1048576 "\", \"used\": \"" $3/1048576 "\", \"free\": \"" $4/1048576 "\" } "}')

#result=$($freeCmd | $awkCmd '$1 ~ /Mem:/ {print "{ \"total\": \"" $2 "\", \"used\": \"" $3 "\", \"free\": \"" $4 "\" } "}')

echo ${result%?} # single line
else
SM_MEMCAP=$(prtconf -pv | grep ^Memory | awk '{print $3}')
SM_MEMUSED=$(swap -sh | awk '{print $8}' | sed 's/M$//')
SM_MEMFREE=$(echo "${SM_MEMCAP}-${SM_MEMUSED}" | bc)
cat << _EOF_
{ "total": "${SM_MEMCAP}", "used": "${SM_MEMUSED}", "free": "${SM_MEMFREE}" }
_EOF_
fi

