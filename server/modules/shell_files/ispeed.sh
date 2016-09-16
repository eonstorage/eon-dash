#!/bin/bash

SCRIPTPATH=`dirname $0`
SPEED_TEST_SCRIPT=$SCRIPTPATH"/../python_files/speedtest_cli.py"

# debug/test
#result=$(cat speedcheck.out | egrep "Upload|Download" | \
#         /bin/awk -F: '{print "{\"" $1 "\": \"" $2 " "B $3 "\"},"}')

result=$($SPEED_TEST_SCRIPT | egrep "Upload|Download" | \
         /bin/awk -F: '{print "{\"" $1 "\": \"" $2 " "B $3 "\"},"}')

echo [ ${result%?} ]
