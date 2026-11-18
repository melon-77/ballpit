# ballpit

The root filesystem skeleton for [Valence](https://github.com/melon-77/valence): `/etc`, the BSD-style rc
scripts, and the few files busybox doesn't provide. Valence's Makefile copies this tree over the busybox
install (this README and `.git` are left out).

Boot order: the kernel runs `/init` (busybox `init`), which reads `etc/inittab`:

- `etc/rc.d/rc.S`: mounts filesystems, sets the hostname, starts mdev and the syslog
- `etc/rc.d/rc.M`: DHCP on each `eth*`, then `rc.local`
- `getty` on `ttyS0`, `tty1` and `tty2`
- `etc/rc.d/rc.6`: on halt or reboot
