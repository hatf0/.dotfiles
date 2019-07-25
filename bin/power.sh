#!/usr/bin/env bash

if [ -z $1 ];then
   echo "Usage: $0 [suspend|reboot|shutdown]"
   exit
fi
if [ $1 = reboot ];then
   sudo /sbin/reboot
elif [ $1 = shutdown ];then
   sudo /usr/bin/shutdown
elif [ $1 = suspend ]; then
   sudo tee /sys/power/state <<< 'mem' 
fi
