#!/bin/bash
#MB=1048576
#GB=1073741824
# raw is in kb
raw=`swap -s | sed -e 's/k//g'`
halloc=`echo $raw | awk '{print $2/1048576}'`
hres=`echo $raw | awk '{print $6/1048576}'`
hused=`echo $raw | awk '{print $9/1048576}'`
havail=`echo $raw | awk '{print $11/1048576}'`

#lots=`kstat -p unix:0:system_pages:lotsfree | awk '{print $2 * 8}'`;
#free=`kstat -p unix:0:system_pages:freemem | awk '{print $2 * 8}'`;
physmem=`kstat -p unix:0:system_pages:physmem | nawk 'BEGIN{ "/usr/bin/pagesize" | getline pgsize ; } {print $2 * pgsize/1048576}'`;
kernlckd=`kstat -p unix:0:system_pages:pp_kernel | nawk 'BEGIN{ "/usr/bin/pagesize" | getline pgsize ; } {print $2 * pgsize/1048576}'`;
lots=`kstat -p unix:0:system_pages:lotsfree | nawk 'BEGIN{ "/usr/bin/pagesize" | getline pgsize ; } {print $2 * pgsize/1048576}'`;
free=`kstat -p unix:0:system_pages:freemem | nawk 'BEGIN{ "/usr/bin/pagesize" | getline pgsize ; } {print $2 * pgsize/1048576}'`;
rem=`echo "($free - $lots)" | bc`
ipcmem=`ipcs -mb 2> /dev/null | awk '/^m/ {sm=sm+$7}END{ print "Shared memory " sm/1073741824 "Gb"}'`

#SWAPH="    Alloc: $halloc Gb Res: $hres Gb Used: $hused Gb Avail: $havail Gb"
#echo "$SWAPH"
#echo "    Freemem: $free Kb Lots: $lots Kb Remainder: $rem Kb"

cat << _EOF_
{ "Physical": "$physmem Gb", "Allocated": "$halloc Gb", "Reserved": "$hres Gb", "Used": "$hused Gb", "Avail": "$havail Gb", "Kernel Locked": "$kernlckd Mb", "Free": "$free Mb", "Lots": "$lots Mb", "Remainder": "$rem Mb" }
_EOF_
