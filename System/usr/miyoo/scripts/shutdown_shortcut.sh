#!/bin/sh
PATH="/mnt/SDCARD/System/bin:$PATH"
export LD_LIBRARY_PATH="/mnt/SDCARD/System/lib:/usr/miyoo/lib:$LD_LIBRARY_PATH"

if [ -f "/tmp/cmd_to_run.sh" ]; then
resume_at_boot=$(jq -r '.["RESUME AT BOOT"]' "/mnt/SDCARD/System/etc/surwish.json")
	if [ "$resume_at_boot" -eq 1 ]; then
		cp /tmp/cmd_to_run.sh /mnt/SDCARD/System/starts/cmd_to_run.sh
		touch /media/sdcard0/factory_test_mode
		echo 'tail -f /dev/null; exit 0' > /media/sdcard0/miyoo355/app/factory_test
		sync
	fi
fi

killall -9 runmiyoo.sh
echo -n "QUIT" | netcat -u -w1 127.0.0.1 55355

while pgrep -f "/mnt/SDCARD/RetroArch/ra64.miyoo" > /dev/null; do
    sleep 0.3
done

Current_Theme=$(/usr/miyoo/bin/jsonval Theme)
Shutdown_Screen="$Current_Theme/skin/shutdown.png"
Shutdown_Text=" "
if [ ! -f "$Shutdown_Screen" ]; then
   if [ -f "$Current_Theme/skin/background.png" ]; then
      Shutdown_Screen="${Current_Theme}skin/background.png"
	  Shutdown_Text="Shutting down..."
   else
      Shutdown_Screen="/media/sdcard0/Themes/Surwish/skin/shutdown.png"
   fi 
fi

/mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -i "$Shutdown_Screen" -m "$Shutdown_Text" -t 3 &

# for mbrola voices:
export XDG_DATA_DIRS=/mnt/SDCARD/System/etc/espeak-ng-data:$XDG_DATA_DIRS
speak-ng --path=/mnt/SDCARD/System/etc -v mb-us2 --stdout "Shutdown" -s 110 | aplay

/mnt/SDCARD/System/bin/shutdown