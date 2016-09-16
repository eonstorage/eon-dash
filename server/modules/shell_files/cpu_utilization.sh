#!/bin/bash
# vmstat interval count
IDLE=`/bin/vmstat 2 2 | /bin/tail -1 | /bin/awk '{print $NF}'`
UTIL=`/bin/expr 100 - $IDLE`

echo -en "$UTIL"
