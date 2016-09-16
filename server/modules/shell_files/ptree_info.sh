#!/bin/bash
# multi-line json

spath=`dirname $0`
result=$(/bin/ptree | \
	 /usr/bin/awk '{print "\"" $1 "\": \"" $2 "\","}' | /bin/sed -e ':a' -e '$N' -e '$ba' -e 's/,\n/\n/')
	 #/usr/bin/awk 'BEGIN {print "{"} {print "\"" $1 "\": \"" $2 "\","} END {print "}"}' | /bin/sed 'N;$s/,\n/\n/;P;D')

echo "{ ${result%?} }" # multi-line
# echo { ${result%?} } # single line
# echo "[ {" ${result%?} "} ]" # single line
