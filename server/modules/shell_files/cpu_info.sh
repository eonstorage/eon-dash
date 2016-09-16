#!/bin/bash

awkCmd=/usr/bin/awk
kstatCmd=/usr/bin/kstat
egrepCmd=/usr/bin/egrep

result=$($kstatCmd -m cpu_info | $egrepCmd -v "^(module:|name:|$)" | \
         $awkCmd '{print "\""$1"\": \""substr($0, index($0,$2))"\","}')

echo "{" ${result%?} "}"
