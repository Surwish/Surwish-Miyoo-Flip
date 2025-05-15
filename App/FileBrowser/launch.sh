#!/bin/sh
echo $0 $*
cd $(dirname "$0")
IP=$(ifconfig wlan0 2>/dev/null | awk '/inet addr:/ { print substr($2, 6) }')
if [ -f $(dirname "$0")/.on ] ; then
	# server on
	pkill -9 wpa_supplicant
	pkill -9 udhcpc
	pkill -9 filebrowser
	./filebrowser config set --branding.name "MiyooFLIP"
	./filebrowser config set --branding.files "/mnt/SDCARD/App/FileBrowser/theme"
	./filebrowser -p 80 -a $IP  -r /mnt/SDCARD &
	# delete mask
	rm $(dirname "$0")/.on
else 
	# server off
killall -9 filebrowser
	# add mask
	touch $(dirname "$0")/.on
fi
sync
