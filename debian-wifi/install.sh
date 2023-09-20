#!/bin/bash

echo "adding to sources"
sed -i '/^deb http:\/\/deb\.debian\.org\/debian\// s/$/ contrib non-free/' /etc/apt/sources.list

echo "installing dependencies"
apt update -y
apt-get install linux-image-$(uname -r|sed 's,[^-]*-[^-]*-,,') linux-headers-$(uname -r|sed 's,[^-]*-[^-]*-,,') -y
apt install broadcom-sta-dkms network-manager -y

modprobe -r b44 b43 b43legacy ssb brcmsmac bcma
modprobe wl
nmcli dev stat
echo "Done!!"
