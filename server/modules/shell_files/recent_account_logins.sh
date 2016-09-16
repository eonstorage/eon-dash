#!/bin/bash

egrepCmd=`which egrep`
lastCmd=`which last`
awkCmd=`which awk`

# filter empty and wtmp begin lines
result=$($lastCmd -n 365 | $egrepCmd -v "^($|wtmp)" | \
         $awkCmd '{
         if (NF == 10) {
            print "{\"user\": \"" $1 "\", \"tty\": \"" $2 "\", \"ip\": \"" $3 "\", \"date\": \""substr($0, index($0,$4))"\"},"
         } else if (NF < 10) {
            print "{\"user\": \"" $1 "\", \"tty\": \"" $2 "\", \"ip\": \""  "\", \"date\": \""substr($0, index($0,$3))"\"},"
         }
         }')
         #$awkCmd '{print "{\"user\": \"" $1 "\", \"ip\": \"" $3 "\", "" \"date\": \"" $5" "$6" "$7" "$8" "$9" "$10"\"},"}')

 echo "[ ${result%?} ]" # multi-line
#echo [ ${result%?} ] # single line
