#!/bin/sh
mount /dev/disk/by-partlabel/config /mnt --read-only
# Read in configs here
config=$(cat /mnt/config)
# copy xorg configuration
cp /mnt/xorg-custom.conf /etc/X11/xorg.conf.d/20-custom.conf

umount /mnt
# Do stuff with configs here

screenConfigLn=$(echo "$config" | grep "screen") #get key=value
screenConfig=${screenConfigLn#*=} #get value
if [ "$screenConfig" == "" ]; then
  screenConfig=VGA1
fi
echo "Screen is $screenConfig"
echo $screenConfig > /root/config/screen

NDIsourceConfigLn=$(echo "$config" | grep "NDIsource")
NDIsourceConfig=${NDIsourceConfigLn#*=}
if [ "$NDIsourceConfig" == "" ]; then
  NDIsourceConfig=none
fi
echo "NDIsource is $NDIsourceConfig"
echo $NDIsourceConfig > /root/config/NDIsource

