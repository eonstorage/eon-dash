# README
- common_applications.sh: shows pkgin ls output (works)
- cpu_info.sh: only output for 2nd cpu showing (wip %60)
- cron_history.sh errors (wip 70%)
- current_ram.sh: works but not sure 100% accurate for all cases (wip)
- ip_addresses.sh: (wip 3 vers 75%)
- io_stats.sh: does not work
- memcached.sh: does not work, removed(no memcached binary but avail in pkgsrc)
- memory_info.sh: (wip 80%)
- network_connections.sh: needs work on column title, ipv4, ipv6 listen dupes
- pm2.sh: shows prstat info
- redis.sh: shows ptree info
- swap.sh: uses swap/prtconf info when no swap devices configured
- scripts not listed are working
-recent_logins "boot system boot" bug on reboot line (works)

# Add(s)
- basic info :: ntp_info network time protocol (works)
- zpool/zfs/snapshot list (wip)
- int_info.sh interface info (works)
- big_proc.sh: has errors parsing ntp, pmap lines (partial)
- smb info (wip)
- zone_info %cpu %mem for zone (wip 80%)
- su_info (works)
