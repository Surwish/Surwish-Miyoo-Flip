#!/bin/sh

IP=$(ifconfig wlan0 2>/dev/null | awk '/inet addr:/ { print substr($2, 6) }')
echo "Current IP address: $IP"

/mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -i "bg-exit.png" -m "Current IP address: $IP" -k " " 
