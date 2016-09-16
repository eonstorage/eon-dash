#!/bin/bash

wCmd=`which w`
awkCmd=`which awk`

result=$(COLUMNS=300 $wCmd -h | $awkCmd '{print "{ \"user\": \"" $1 "\", \"tty\": \"" $2 "\", \"from\": \"" $3 "\", \"when\": \"" $4 "\" },"}')

# echo "[ ${result%?} ]" # multi-line
echo [ ${result%?} ] # single line
