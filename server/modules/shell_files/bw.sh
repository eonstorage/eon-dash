#!/bin/sh
# usage: bw DEV [INTERVAL]
DEV=$1
IVAL=${2:-5}

getrxtx() { kstat -p "*:*:$1:*bytes64" | awk '{print $2}' ; }

rxtx=`getrxtx $DEV`
while sleep $IVAL; do
    nrxtx=`getrxtx $DEV`
    (echo $IVAL $rxtx $nrxtx) |
    awk 'BEGIN {
          msg = "%6.2f MB/s RX %6.2f MB/s TX\n"}
         {rxd = ($4 - $2) / (1024*1024*$1);
          txd = ($5 - $3) / (1024*1024*$1);
          printf msg, rxd, txd}'
    rxtx="$nrxtx"
done
