#!/bin/sh


read -r device_type </userdata/current_device.txt


	src_dir="/mnt/SDCARD/App/BootLogo/Images_${device_type}/"
	CrossMixFWfile="/mnt/SDCARD/miyoo/firmwares/MinFwVersion_${device_type}.txt"
thumb_dir="/mnt/SDCARD/App/BootLogo/Thumbnails_${device_type}/"

if [ "$current_device" = "miyooflip" ]; then
	Current_FW_Revision=$(cat /usr/miyoo/version)
else

	Current_FW_Revision=$(grep 'DISTRIB_DESCRIPTION' /etc/openwrt_release | cut -d '.' -f 3)

fi 
Required_FW_Revision=$(sed -n '2p' "$CrossMixFWfile")


if [ "$Current_FW_Revision" -gt "$Required_FW_Revision" ]; then # on firmware hotfix 9 there is less space than before on /dev/mmcblk0p1 so we avoid to flash the logo
	/mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -m "Not compatible with firmware superior to $Current_FW_Revision." -t 3
    exit 1
fi

echo performance >/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 1416000 >/sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq

LD_LIBRARY_PATH="/mnt/SDCARD/System/lib:/usr/miyoo/lib:$LD_LIBRARY_PATH"

rm -f ./GoBackTo_Apps.json
cp /tmp/state.json ./GoBackTo_Apps.json
cp ./GoTo_Bootlogo_List.json /tmp/state.json





find "$thumb_dir" -type f -not -name "- Default miyoo.png" -exec rm -f {} \;
sync

/mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -m "Generating thumbnails..." -t 2 &

# Rename files to start with a capital letter
find "$src_dir" -type f -iname "*.bmp" | while read -r bmp_file; do
    filename=$(basename "$bmp_file")
    dirname=$(dirname "$bmp_file")
    new_filename="$(echo "$filename" | awk '{print toupper(substr($0,1,1)) substr($0,2)}')"
    # Lowercase extension
    new_filename="$(echo "$new_filename" | sed 's/\.BMP$/.bmp/I')"
    # replace underscores by spaces
    # new_filename="$(echo "$new_filename" | sed 's/_/ /g')"
    mv "$bmp_file" "$dirname/$new_filename"
done
sync

# Create thumbnails
find "$src_dir" -type f -iname "*.bmp" | while read -r bmp_file; do
    filename=$(basename "$bmp_file")
    if [ "$filename" != "- Default miyoo.bmp" ]; then
        png_dest="$thumb_dir${filename%.bmp}.png"
        /mnt/SDCARD/System/bin/gm convert "$bmp_file" -resize 300x\> "$png_dest"
    fi
done
sync

rm -f "/mnt/SDCARD/App/BootLogo/Thumbnails/Thumbnails_cache7.db"
echo "All conversions have been made."

sync
exit
