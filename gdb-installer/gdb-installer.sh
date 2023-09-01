#!/bin/bash

echo "Downloading GDB source"
gdb_version=$(curl -s https://ftp.gnu.org/gnu/gdb/ | grep -o  'gdb.*\.tar\.gz"' | sed 's/"//g' | tail -n 3 | head -n 1)
wget "https://ftp.gnu.org/gnu/gdb/$gdb_version" -O "/tmp/$gdb_version"

echo "Extracting GDB"
cd /tmp
tar xf "$gdb_version"
gdb_folder=$(echo "$gdb_version" | sed 's/\.tar\.gz//g')
cd "$gdb_folder"

echo "Making and Installing GDB"
sh configure
make
sudo make install

echo "Installation Finished"
exit
