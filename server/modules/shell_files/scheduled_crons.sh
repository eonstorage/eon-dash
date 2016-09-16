#!/bin/bash
# multi-line json: [ { }, { } ]

/bin/echo "["
for user in `cat /etc/passwd | awk -F: '{print $1}'`
do
  /bin/crontab -l $user > /dev/null 2>&1
  [ "$?" = "0" ] && {
    crontab -l $user | egrep -v '^(#|$)' | \
      awk '{print "{ \"user\": \"'$user'\", \"min(s)\": \"" $1 "\", \"hours(s)\": \"" $2 "\", \"day(s)\": \"" $3 "\", \"month\": \"" $4 "\", \"weekday\": \"" $5 "\", \"command\": \""substr($0, index($0,$6))"\" }," }'
  }
done | tr '\n' ' ' | sed 's/, $//'

/bin/echo "]"
