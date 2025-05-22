#!/bin/sh
PATH="/mnt/SDCARD/System/bin:$PATH"
export LD_LIBRARY_PATH="/mnt/SDCARD/System/lib:/mnt/SDCARD/System/lib/samba:/mnt/SDCARD/Apps/PortMaster/PortMaster:/usr/miyoo/lib:$LD_LIBRARY_PATH"

echo $0 $*
progdir=$(dirname "$0")
homedir=$(dirname "$1")
extension="${@##*.}"

cd "$progdir"


if [ "$extension" = "launch" ]; then
	sh "$1"
	exit
fi

if [ "$extension" = "m3u8" ]; then
  if [ -f "./streaming_manual.png" ]; then
    /mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -i "./streaming_manual.png" -k "A B Y X L R SELECT START MENU"
    mv ./streaming_manual.png ./streaming_manual_done.png
  fi
fi



export LD_LIBRARY_PATH=/lib:/lib64:/usr/lib:/mnt/SDCARD/System/lib/

/mnt/SDCARD/App/PortMaster/PortMaster/gptokeyb2 -1 "mpv" -c "keys.gptk" &
/mnt/SDCARD/System/bin/thd --triggers thd.conf /dev/input/event5 &

echo 1 >/tmp/stay_awake
HOME="$progdir" /mnt/SDCARD/System/bin/mpv "$@" --fullscreen --audio-buffer=1 --terminal=no # --lavfi-complex="[aid1]asplit[ao][a]; [a]showcqt[vo]" --script=/mnt/SDCARD/Emus/VIDEOS/.config/mpv/metadata_osd.lua  #--autofit=100%x1280    # for music: --geometry=720   # visu: --lavfi-complex="[aid1]asplit[ao][a]; [a]showcqt[vo]"
rm /tmp/stay_awake

kill -9 $(pidof gptokeyb2)
kill -9 $(pidof thd)
