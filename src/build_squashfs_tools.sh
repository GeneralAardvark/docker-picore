#!/bin/sh

if [ ! -f squashfs-tools.tcz ]; then
    wget http://tinycorelinux.net/8.x/armv7/tcz/squashfs-tools.tcz
fi

[ -d /mnt ] || mkdir /mnt
mount -t squashfs -o loop,ro,bs=4096 squashfs-tools.tcz /mnt
tar cf - -C /mnt . | gzip -c
