#!/bin/bash

# kstat -p 'unix:0:system_misc:ncpus'
numCores=$(/usr/sbin/psrinfo -p)

if [ $numCores -eq 0 ] ; then
   echo "cannnot be found"
fi
