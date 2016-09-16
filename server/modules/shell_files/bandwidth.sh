#!/bin/sh
IVAL=${1:-2} # if $1 null default sample interval 2 secs

getrxtx() { kstat -p "*:*:$1:*bytes64" | awk '{print $2}' ; }

for DEV in `dladm show-phys -p -o link`
do
rxtx=`getrxtx $DEV`
sleep $IVAL
nrxtx=`getrxtx $DEV`
result=$(echo $IVAL $rxtx $nrxtx | \
         awk '{ \
         rxd = ($4 - $2) / (1024*1024*$1); \
         txd = ($5 - $3) / (1024*1024*$1);
         print "{ \"interface\": \"'$DEV'\", \"rx\": \"" rxd " Mb/s\", \"tx\": \"" txd " Mb/s\" } "}
         #print "{ \"interface\": \"'$DEV'\", \"rx\": \"" %.2f "\", \"tx\": \"" %.2f "\" } ", rxd, txd}
         #printf "{ \"interface\": \"'$DEV'\", \"rx\": \"" %6.2f "\", \"tx\": \"" txd "\" } " , rxd, txd }
         ')
         #{rxd = ($4 - $2) / (1024*1024*$1); \
         #txd = ($5 - $3) / (1024*1024*$1);
         #printf msg, rxd, txd}')
done

# echo "[ ${result%?} ]" # multi-line
echo [ ${result%?} ] # single line
