#!/bin/bash

echo "installing dependencies"
apt install samba smbclient cifs-utils -y

echo "copying samba configurations"
cat "$PWD/smb.conf" | tee -a /etc/samba/smb.conf

echo "creating users and groups"
groupadd smbshare
mkdir /home/public
mkdir /home/private

chgrp -R smbshare /home/public
chgrp -R smbshare /home/private

chmod 2775 /home/public
chmod 2770 /home/private

useradd -M -s /sbin/nologin sambauser
usermod -aG smbshare sambauser

smbpasswd -a sambauser
smbpasswd -e sambauser

echo "restarting smb service"
systemctl restart nmbd

echo "allowing through firewall"
IP=$(ip addr | grep '192.168' | awk '{print $2}' |awk -F'[./]' '{print $1"."$2"."$3"."0"/24"}' | head -n 1)
ufw allow from $IP to any app Samba comment 'Samba Share'

echo "Done!"
