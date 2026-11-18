#!/bin/sh
# /etc/rc.d/rc.M -- multiuser startup.

PATH=/sbin:/usr/sbin:/bin:/usr/bin
export PATH

for i in /sys/class/net/eth*; do
  [ -e "$i" ] || continue
  dev=${i##*/}
  echo "Bringing up $dev via DHCP"
  ifconfig "$dev" up
  udhcpc -b -q -t 3 -i "$dev" >/dev/null 2>&1
done

[ -x /etc/rc.d/rc.local ] && /etc/rc.d/rc.local
:
