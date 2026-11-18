#!/bin/sh
# /etc/rc.d/rc.S -- system initialization. Runs once at boot.

PATH=/sbin:/usr/sbin:/bin:/usr/bin
export PATH

mount -t proc     proc     /proc
mount -t sysfs    sysfs    /sys
mount -t devtmpfs devtmpfs /dev 2>/dev/null
mkdir -p /dev/pts /dev/shm
mount -a                          # the rest of /etc/fstab

echo "Setting hostname: $(cat /etc/HOSTNAME)"
hostname -F /etc/HOSTNAME

# Let mdev handle hotplug events
echo /sbin/mdev > /proc/sys/kernel/hotplug
mdev -s

ifconfig lo 127.0.0.1 up

echo "Starting system logger"
syslogd
klogd

dmesg -n 3                        # keep kernel chatter off the console
