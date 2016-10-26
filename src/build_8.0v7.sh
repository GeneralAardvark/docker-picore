#!/bin/sh

wget -q http://tinycorelinux.net/8.x/armv7/releases/RPi/piCore-8.0.zip 
unzip -qq piCore-8.0.zip 
mkdir /mnt 
OFFSET=$((`fdisk -ul piCore-8.0.img | awk '($1~"img1$"){print $2}'`*512)) 
losetup -o $OFFSET /dev/loop2 piCore-8.0.img 
mount /dev/loop2 /mnt 
mkdir 8.0v7 
cd 8.0v7 
gzip -dc /mnt/8.0v7.gz | cpio -id 
cd usr/bin 
chmod u+s sudo
patch < /tmp/tce-load.patch 
cd ../..
tar cf - . | gzip -c > /tmp/8.0v7.tgz
