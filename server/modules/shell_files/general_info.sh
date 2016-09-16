#!/bin/bash

function displaytime {
  local T=$1
  local D=$((T/60/60/24))
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  [[ $D > 0 ]] && printf '%d days ' $D
  [[ $H > 0 ]] && printf '%d hours ' $H
  [[ $M > 0 ]] && printf '%d minutes ' $M
  [[ $D > 0 || $H > 0 || $M > 0 ]] && printf 'and '
  printf '%d seconds\n' $S
}

release=$(/bin/uname -v | sed -e 's/^"//'  -e 's/"$//')
uname=$(/bin/uname -n | sed -e 's/^"//'  -e 's/"$//')
os=`echo $uname-$release`
hostname=$(/bin/hostname)
up_time=$(/bin/uptime | /bin/awk -F, '{print $1" "$2}' | /bin/awk '{print $3" "$4" "$5}')
server_time=$(date)
boot_status=$(/bin/who -r | /bin/awk '{print $2" "$3" "$4" "$5" "$6}')
kernel_modules=$(isainfo -kv)
# prtdiag (1 line) vs smbios -t 0 (3 lines)
bios_info=$(/usr/sbin/prtdiag | grep "^BIOS" | /bin/awk '{print substr($0, index($0,$3))}')
hw_info=$(/usr/sbin/prtdiag | grep "^System" | /bin/awk '{print substr($0, index($0,$3))}')
serial_info=$(/usr/sbin/smbios -t 1 | grep "Serial" | /bin/awk '{print substr($0, index($0,$3))}')
ram_info=$(/usr/sbin/prtconf | grep "^Memory" | /bin/awk '{print substr($0, index($0,$3))}')
host_id=$(/usr/bin/hostid)

echo { \
     \"OS\": \"$os\", \
     \"Hostname\": \"$hostname\", \
     \"Uptime\": \"$up_time\", \
     \"Server Time\": \"$server_time\", \
     \"Boot Status\": \"$boot_status\", \
     \"Kernel Modules\": \"$kernel_modules\", \
     \"Bios\": \"$bios_info\", \
     \"Hardware\": \"$hw_info\", \
     \"HW Serial\": \"$serial_info\", \
     \"Memory\": \"$ram_info\", \
     \"Hostid\": \"$host_id\" \
     }
