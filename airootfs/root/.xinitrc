#!/bin/sh
screen=$(cat /root/config/screen)
NDIsource=$(cat /root/config/NDIsource)
while [ "$(xrandr | grep "$screen connected")" == "" ];
do
  sleep 2
done
xrandr --output $screen --auto --primary

/root/NDI-Simple-Monitor/Nsm.x86_64  --hide-ui --source "$NDIsource"
