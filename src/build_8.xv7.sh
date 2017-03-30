#!/bin/sh

VERSION="8.1.5"

wget -q http://tinycorelinux.net/8.x/armv7/releases/RPi/piCore-${VERSION}.zip
unzip -qq piCore-${VERSION}.zip
mkdir /mnt
OFFSET=$((`fdisk -ul piCore-${VERSION}.img | awk '($1~"img1$"){print $2}'`*512))
losetup -o $OFFSET /dev/loop2 piCore-${VERSION}.img
mount /dev/loop2 /mnt
mkdir ${VERSION}v7
cd ${VERSION}v7
gzip -dc /mnt/${VERSION}v7.gz | cpio -id
cd usr/bin
chmod u+s sudo
patch < /tmp/tce-load.patch
cd ../..
tar cf - . | gzip -c > /tmp/${VERSION}v7.tgz
