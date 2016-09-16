#!/bin/bash
# output: { "Download:": "490.26 Mbits/s", "Upload:": "118.07 Mbits/s" }
errmsg="[ { \"error\": \"`basename $0`\" } ]"

SCRIPTPATH=`dirname $0`
SPEED_TEST_SCRIPT=$SCRIPTPATH"/../python_files/speedtest_cli.py"

#result=$(cat $SCRIPTPATH/speedcheck.out | egrep "Upload|Download" | \
#         /bin/awk '{print "\"" $1 "\": \"" $2 " " $3 "\","}')
result=$($SPEED_TEST_SCRIPT | egrep "Upload|Download" | \
         /bin/awk '{print "\"" $1 "\": \"" $2 " " $3 "\","}')

if [ -z "$result" ] ; then
   echo $errmsg
else
   # echo "{ ${result%?} }" # multi-line
   echo { ${result%?} } # single line
fi
