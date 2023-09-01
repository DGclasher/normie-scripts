#!/bin/bash

gdb_version=$(curl -s https://ftp.gnu.org/gnu/gdb/ | grep -o  'gdb.*\.tar\.gz"' | sed 's/"//g' | tail -n 3 | head -n 1)
gdb_folder=$(echo "$gdb_version" | sed 's/\.tar\.gz//g')

echo "Checking if gdb version already exists"
if [ ! -d "/opt/$gdb_folder" ]
then
    echo "Downloading GDB source"
    sudo wget "https://ftp.gnu.org/gnu/gdb/$gdb_version" -O "/opt/$gdb_version"

    echo "Extracting GDB"
    cd /opt
    sudo tar xf "$gdb_version"
    sudo rm "$gdb_version"
fi

cd "/opt/$gdb_folder"
echo "Making and Installing GDB"
sh configure --with-python=/usr/bin/python3
sudo make
sudo make install

echo "Installation Finished"
exit
