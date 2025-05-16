#!/bin/sh

echo $0 $*

read -r device_type </userdata/current_device.txt
src_dir="/mnt/SDCARD/App/BootLogo/Images_${device_type}/"

PATH="/mnt/SDCARD/System/bin:$PATH"
export LD_LIBRARY_PATH="/mnt/SDCARD/System/lib:/mnt/SDCARD/System/lib/samba:/mnt/SDCARD/Apps/PortMaster/PortMaster:/usr/miyoo/lib:$LD_LIBRARY_PATH"
export MAGICK_CODER_MODULE_PATH="/mnt/SDCARD/System/bin/imagemagick/lib64/ImageMagick-6.9.10/modules-Q16/coders/"

LOG_FILE="/mnt/SDCARD/App/BootLogo/BootLogo.log"

exec >>$LOG_FILE 2>&1
echo "===================================="
date +'%Y-%m-%d %H:%M:%S'
echo "===================================="
silent=0
input_file="$1"
filename=$(basename "$input_file")
extension="${filename##*.}"
filename="${filename%.*}"

# Manage 2 cases : bmp directly in parameter to this script or from the BootLogo app
if [ "$extension" = "bmp" ]; then
	SOURCE_FILE="$input_file"
	silent=1
else
	SOURCE_FILE="$src_dir/${filename}.bmp"
fi

if [ $? -ne 0 ]; then
	echo "Failed to mount $TARGET_PARTITION."
	sync
	exit 1
fi

echo "Source file: $SOURCE_FILE"

if [ -f "$SOURCE_FILE" ]; then
	echo "Moving $SOURCE_FILE..."

	# Get the current screen resolution using fbset and extract the width and height with awk
	screen_resolution=$(fbset | awk '/geometry/ {print $2, $3}')
	screen_width=$(echo "$screen_resolution" | cut -d' ' -f1)
	screen_height=$(echo "$screen_resolution" | cut -d' ' -f2)

	# Get the resolution of the source image
	resolution=$(/mnt/SDCARD/System/bin/gm identify -format "%w %h" "$SOURCE_FILE")
	width=$(echo "$resolution" | cut -d' ' -f1)
	height=$(echo "$resolution" | cut -d' ' -f2)

	echo "Resolution of \"$filename\" is: ${width}x${height}"

	################# Check if the resolution matches the screen resolution #################
	if [ "$width" -gt "$screen_width" ] || [ "$height" -gt "$screen_height" ]; then
		echo "The image \"$filename\" is too large. Quitting without flash."
		[ "$silent" -eq 0 ] && /mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -i "$SOURCE_FILE" -m "Image resolution is larger than expected, exiting. (${width}x${height} instead of ${screen_width}x${screen_height})" -t 5 -c "220,0,0"
		exit 1
	elif [ "$width" -lt "$screen_width" ] || [ "$height" -lt "$screen_height" ]; then
		echo "The image \"$filename\" is too small. Not recommended but should be OK."
		[ "$silent" -eq 0 ] && /mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -i "$SOURCE_FILE" -m "Image resolution is smaller than expected. (${width}x${height} instead of ${screen_width}x${screen_height})" -t 5 -c "220,0,0"
	else
		echo "The image \"$filename\" has a resolution of ${screen_width}x${screen_height}. Let's continue!"
	fi

	################# Check if file type is BMP #################
	file_type=$(/mnt/SDCARD/System/bin/gm identify -format "%m" "$SOURCE_FILE")
	if [ "$file_type" = "BMP" ]; then
		echo "\"$filename\" is a BMP image. Let's continue !"
	else
		echo "\"$filename\" is not a BMP image. Quitting without flash."
		sync
		[ "$silent" -eq 0 ] && /mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -i "$SOURCE_FILE" -c "220,0,0" -m "Image is not a real .bmp file, check the format and convert it." -t 5 -c "220,0,0"
		exit 1
	fi

	################# Check file size #################
	max_size_bytes=$((6 * 1024 * 1024))
	file_size=$(stat -c "%s" "$SOURCE_FILE")
	echo "Size of $file is: $file_size bytes"

	if [ "$file_size" -lt "$max_size_bytes" ]; then
		echo "\"$filename\" has size less than 6MB. Let's continue !"
	else
		echo "\"$filename\" exceeds 6MB. Quitting without flash."
		[ "$silent" -eq 0 ] && /mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -i "$SOURCE_FILE" -m "Image file is too big (6MB maximum)" -t 6 -c "220,0,0"
	fi

	################# Flashing logo #################
	button=$(/mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -i "$SOURCE_FILE" -m "Press A to flash, B to cancel." -fs 19 -k "A B")

	# button=$(/mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -i "/mnt/SDCARD/System/firmwares/FW_Update_Instructions.png" -k "A B")

	if [ "$button" = "A" ]; then

		[ "$silent" -eq 0 ] && /mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -i "$SOURCE_FILE" -m "Flashing logo..." -fs 50 -t 60 &
		# Extracting Boot Image
		echo "Extracting Boot files..."

		dd if=/dev/mtd2ro of=/tmp/bootlogo_partition bs=131072
		# Unpacking Boot Image
		echo "Unpacking Boot files..."
		mkdir -p /tmp/bootlogo
		unpack_bootimg --boot_img /tmp/bootlogo_partition --out /tmp/bootlogo
		# Unpacking Resources
		bootlogo_dir="/tmp/bootlogo/partition-second"
		mkdir -p "$bootlogo_dir"
		cd "$bootlogo_dir"
		rsce-arm64-linux -u /tmp/bootlogo/second

		cp "$SOURCE_FILE" "$bootlogo_dir/logo.bmp"
		if [ $? -ne 0 ]; then
			echo "Failed to move logo file."
		else
			echo "logo file moved successfully."
		fi
		cp "$SOURCE_FILE" "$bootlogo_dir/logo_kernel.bmp"
		if [ $? -ne 0 ]; then
			echo "Failed to move logo_kernel file."
		else
			echo "logo_kernel file moved successfully."
		fi
		sync

		set --
		for file in *; do
			[ -f "$file" ] && set -- "$@" -p "$bootlogo_dir/$file"
		done
		rsce-arm64-linux "$@"
		mkbootimg --kernel ../kernel --second ./boot-second --base 0x10008000 --kernel_offset 0x00008000 --ramdisk_offset 0x0 --second_offset 0x00f00000 --pagesize 2048 -o bootlogo

		flashcp bootlogo /dev/mtd2
		rm -rf /tmp/bootlogo
		rm /tmp/bootlogo_partition

		sync

		[ "$silent" -eq 0 ] && /mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -i "$SOURCE_FILE" -m "Flash done !" -c "0,220,0" -fs 50 -t 2

	fi
	###############################################
	# echo "Mounting $TARGET_PARTITION to $MOUNT_POINT..."
	# mkdir -p $MOUNT_POINT
	# mount $TARGET_PARTITION $MOUNT_POINT

	# [ "$silent" -eq 0 ] && /mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -i "$SOURCE_FILE" -m "Flashing logo..." -fs 100 -t 2.5

	# cp "$SOURCE_FILE" "$MOUNT_POINT/bootlogo.bmp"
	# if [ $? -ne 0 ]; then
	# echo "Failed to move bootlogo file."
	# else
	# echo "Bootlogo file moved successfully."
	# fi
	# sync
	# if ! cmp -s "$SOURCE_FILE" "$MOUNT_POINT/bootlogo.bmp"; then
	# The flashed file is different from the source, we restore the default logo
	# rm "$MOUNT_POINT/bootlogo.bmp"
	# cp "/mnt/SDCARD/App/BootLogo/Images/- Default Trimui.bmp" "$MOUNT_POINT/bootlogo.bmp"
	# fi
	# sync
	# sleep 0.5
	# sync
	# [ "$silent" -eq 0 ] && cp /mnt/SDCARD/App/BootLogo/GoBackTo_Apps.json /tmp/state.json
	# sync

	################# End of flash #################

	# [ "$silent" -eq 0 ] && /mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -i "$SOURCE_FILE" -m "Flash done !" -c "0,220,0" -fs 100 -t 0.5

else
	echo "Source file does not exist."
	exit 1
fi

echo "Unmounting $TARGET_PARTITION..."
# umount $TARGET_PARTITION

# rmdir $MOUNT_POINT

echo "Script completed."

# we don't memorize System Tools scripts in recent list
if [ "$silent" -eq 0 ]; then
	recentlist=/mnt/SDCARD/Roms/recentlist.json
	sed -i '/_BootLogo\/launch.sh/d' $recentlist
fi
sync
