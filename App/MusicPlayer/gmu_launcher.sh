#!/bin/sh
export LD_LIBRARY_PATH=/mnt/SDCARD/System/lib/:/lib:/lib64:/mnt/SDCARD/App/PortMaster/PortMaster:/usr/lib:LD_LIBRARY_PATH

settings_file="/mnt/SDCARD/App/MusicPlayer/gmu.settings.conf"
first_run_file="/mnt/SDCARD/App/MusicPlayer/FirstRunDone"

cd /mnt/SDCARD/App/MusicPlayer

/mnt/SDCARD/App/PortMaster/PortMaster/gptokeyb2 "gmu.bin" -c "/mnt/SDCARD/App/MusicPlayer/gptokeyb.gptk" &
sleep 0.4

# To support LCD switch-Off key combination
/mnt/SDCARD/System/bin/thd --triggers /mnt/SDCARD/App/MusicPlayer/thd.conf /dev/input/event3 &

echo 1 >/tmp/stay_awake
HOME=/mnt/SDCARD/App/MusicPlayer /mnt/SDCARD/App/MusicPlayer/gmu.bin -c gmu.settings.conf
rm /tmp/stay_awake

kill -9 $(pidof gptokeyb2)
kill -9 $(pidof thd)

# Check if the FirstRunDone file exists
if ! [ -f "$first_run_file" ]; then
    sed -i 's/^Gmu.FirstRun=.*/Gmu.FirstRun=no/' "$settings_file"
    touch "$first_run_file"
fi

sync
