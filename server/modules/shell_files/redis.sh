#!/bin/bash

spath=`dirname $0`
result=$(/bin/ptree | \
	 /usr/bin/awk '{print "\"" $1 "\": \"" $2 "\","}' | /bin/sed -e ':a' -e '$N' -e '$ba' -e 's/,\n/\n/')

echo "{ ${result%?} }" # multi-line
# echo { ${result%?} } # single line
