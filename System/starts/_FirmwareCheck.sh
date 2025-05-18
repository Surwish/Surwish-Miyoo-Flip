#!/bin/sh

if ! read -r current_device </userdata/current_device.txt; then
    display=$(fbset | grep ^mode | cut -d "\"" -f 2)
    if [ "$display" = "1280x720-64" ]; then
        current_device="tsp"
    elif [ "$display" = "640x480-0" ]; then
        current_device="miyooflip"
    else
        current_device="brick"
    fi
    echo -n $current_device >/userdata/current_device.txt
fi

read -r last_device </mnt/SDCARD/System/etc/last_device.txt
if [ "$current_device" != "$last_device" ]; then
    echo -n $current_device >/mnt/SDCARD/System/etc/last_device.txt
    touch /tmp/device_changed
fi

################ check min Firmware version required ################

SurwishFWfile="/mnt/SDCARD/System/firmwares/MinFwVersion_$current_device.txt"

if [ "$current_device" = "miyooflip" ]; then
    Current_FW_Revision=$(cat /usr/miyoo/version)
else

    Current_FW_Revision=$(grep 'DISTRIB_DESCRIPTION' /etc/openwrt_release | cut -d '.' -f 3)

fi
Required_FW_Revision=$(sed -n '2p' "$SurwishFWfile")

echo "Current FW Revision: $Current_FW_Revision"
echo "Required FW Revision: $Required_FW_Revision"

if [ -z "$Current_FW_Revision" ] || [ -z "$Required_FW_Revision" ]; then

    echo "Firmware check not possible."

else
    FIRMWARE_PATH="/mnt/SDCARD/System/firmwares/miyoo355_fw.7z"
    FIRMWARE_FILE="miyoo355_fw.img"
    if [ "$Current_FW_Revision" -lt "$Required_FW_Revision" ]; then

        pgrep -f miyoo_inputd >/dev/null || /media/sdcard0/miyoo355/app/miyoo_inputd & # we need input

        echo "Current firmware ($Current_FW_Revision) must be updated to $Required_FW_Revision to support Surwish OS v$version."

        # Install new busybox from PortMaster, credits : https://github.com/kloptops/TRIMUI_EX

        # Current_busybox_crc=$(crc32 "/bin/busybox" | awk '{print $1}')
        # target_busybox_crc=$(crc32 "/mnt/SDCARD/System/usr/trimui/scripts/busybox" | awk '{print $1}')

        # if [ "$Current_busybox_crc" != "$target_busybox_crc" ]; then

        # make some place
        # rm -rf /usr/trimui/apps/zformatter_fat32/
        # rm -rf /usr/trimui/res/sound/bgm2.mp3
        # swapoff -a
        # rm -rf /swapfile
        # cp "/mnt/SDCARD/trimui/res/skin/bg.png" "/usr/trimui/res/skin/"

        # cp -vf /bin/busybox /mnt/SDCARD/System/bin/busybox.bak
        # /mnt/SDCARD/System/bin/rsync /mnt/SDCARD/System/usr/trimui/scripts/busybox /bin/busybox
        # ln -vs "/bin/busybox" "/bin/bash"

        # Create missing busybox commands
        # for cmd in $(busybox --list); do
        # Skip if command already exists or if it's not suitable for linking
        # if [ -e "/bin/$cmd" ] || [ -e "/usr/bin/$cmd" ] || [ "$cmd" = "sh" ]; then
        # continue
        # fi

        # Create a symbolic link
        # ln -vs "/bin/busybox" "/usr/bin/$cmd"
        # done

        # Fix weird libSDL location
        # for libname in /usr/trimui/lib/libSDL*; do
        # linkname="/usr/lib/$(basename "$libname")"
        # if [ -e "$linkname" ]; then
        # continue
        # fi
        # ln -vs "$libname" "$linkname"
        # done
        # fi

        sync
        killall -9 runmiyoo.sh
        killall -9 MainUI
        killall -9 keymon
        killall -9 btmanager
        killall -9 hardwareservice
        button=$(/mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -i "/mnt/SDCARD/System/firmwares/FW_Informations.png" -m " $Current_FW_Revision                               $Required_FW_Revision" -fs 19 -k "A B")

        # button=$(/mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -i "/mnt/SDCARD/System/firmwares/FW_Update_Instructions.png" -k "A B")

        if [ "$button" = "A" ]; then
            # /mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -i "/mnt/SDCARD/System/firmwares/FW_Copy.png" -m "Please wait, copying Firmware v$Required_FW_Version - $Required_FW_Revision..."

            /mnt/SDCARD/System/bin/7zz x "$FIRMWARE_PATH" -o"/mnt/SDCARD" -y
            sync

            # Extract CRC from the 7z archive
            ARCHIVE_CRC=$(/mnt/SDCARD/System/bin/7zz l "$FIRMWARE_PATH" -slt "$FIRMWARE_FILE" | grep "CRC = " | awk '{print $3}' | tr 'a-f' 'A-F')

            # Calculate CRC of the extracted file
            EXTRACTED_CRC=$(crc32 "/mnt/SDCARD/$FIRMWARE_FILE" | awk '{print $1}' | tr 'a-f' 'A-F')

            # Compare the CRC values
            if [ "$ARCHIVE_CRC" == "$EXTRACTED_CRC" ]; then
                echo "FW CRC check passed: $EXTRACTED_CRC"
            else
                echo "CRC check failed: Archive CRC = $ARCHIVE_CRC, Extracted CRC = $EXTRACTED_CRC"
                /mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -i bg-exit.png -m "Firmware CRC check has failed, canceling update." -k A
            fi

            sleep 1
            sync
            killall -9 runmiyoo.sh
            killall -9 MainUI
            killall -9 keymon
            killall -9 btmanager
            killall -9 hardwareservice
            killall -9 miyoo_inputd
            killall -9 smbd
            cd /media/sdcard0
            /usr/miyoo/apps/fw_update/miyoo_fw_update
            exit
        else
            rm -f "/mnt/SDCARD/$FIRMWARE_FILE"
        fi

    else
        echo "Firmware version $Current_FW_Revision OK."
        rm -f "/mnt/SDCARD/$FIRMWARE_FILE"

        read -r version </mnt/SDCARD/System/usr/miyoo/surwish-version.txt
        read -r FW_patched_version </userdata/surwish-version.txt

        if [ "$Current_FW_Revision" -lt "20250228101927" ]; then
            if [ "$version" != "$FW_patched_version" ]; then

                # Flash bootlogo

                killall -9 runmiyoo.sh
                killall -9 MainUI
                sleep 0.5

                ####################################
                ## force flash
                # FILE="/mnt/SDCARD/System/firmwares/bootlogo_surwish"
                # CHECKSUM_FILE="${FILE}.sha256"
                # cd "$(dirname "$FILE")"
                # if sha256sum -c "$(basename "$CHECKSUM_FILE")"; then
                # echo "Checksum valid. Flashing bootlogo..."
                # flashcp "$FILE" /dev/mtd2
                # if [ $? -eq 0 ]; then
                # echo "Flash completed successfully."
                # else
                # echo "Flash failed."
                # fi
                # else
                # echo "Checksum mismatch. Aborting."
                # exit 1
                # fi
                ####################################

                # ask for bootlogo flash
                "/mnt/SDCARD/Emu/_BootLogo/launch.sh" "Surwish.png"
                echo $version >/userdata/surwish-version.txt

                /mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -m "Surwish-OS installation..." -t 30 &
                "/mnt/SDCARD/System/starts/°customization.sh"
                killall -9 infoscreen.sh sdl2imgshow

                /etc/init.d/S60mainui start
            fi
        fi

    fi
fi

# flashcp /mnt/SDCARD/System/firmwares/bootlogo_surwish /dev/mtd2
################ check if a Surwish-OS update is available ################

# Set PATH and library path
PATH="/mnt/SDCARD/System/bin:/mnt/SDCARD/System/usr/miyoo/scripts/:$PATH"
export LD_LIBRARY_PATH="/mnt/SDCARD/System/lib:/usr/miyoo/lib:$LD_LIBRARY_PATH"

# Find the update file
UPDATE_FILE=$(find /mnt/SDCARD -maxdepth 1 -name "Surwish-OS_v*.zip" -print -quit)

if [ -n "$UPDATE_FILE" ]; then
    pgrep -f /media/sdcard0/miyoo355//app/miyoo_inputd >/dev/null || /media/sdcard0/miyoo355/app/miyoo_inputd & # we need input
    echo "Surwish-OS install file found: $UPDATE_FILE"
    initial_version=$(cat /mnt/SDCARD/System/usr/miyoo/surwish-version.txt)
    update_version=$(echo "$UPDATE_FILE" | awk -F'_v|\.zip' '{print $2}')

    # Compare the versions
    if [ "$(echo "$update_version" | tr -d '.')" -gt "$(echo "$initial_version" | tr -d '.')" ]; then
        echo "The Surwish update file (v$update_version) is greater than the current version installed ($initial_version)."

        minspace=$((20 * 1024))
        rootfs_space=$(df / | awk 'NR==2 {print $4}')
        if [ "$rootfs_space" -lt "$minspace" ]; then
            echo "Error: Available space on internal storage is less than 20 MB"
            infoscreen.sh -m "Surwish-OS update v$update_version found. Not enough space on internal storage to update." -k "A B START MENU"
            exit 1
        else
            echo "Available space on / is sufficient: ${rootfs_space} KB"
        fi

        if [ ! -f "/mnt/SDCARD/miyoo/res/surwish-os/bg-info.png" ] ||
            [ ! -f "/mnt/SDCARD/System/bin/sdl2imgshow" ] ||
            [ ! -f "/mnt/SDCARD/System/usr/miyoo/scripts/surwish_update.sh" ] ||
            [ ! -f "/mnt/SDCARD/System/usr/miyoo/scripts/getkey.sh" ] ||
            [ ! -f "/mnt/SDCARD/System/usr/miyoo/scripts/common_launcher.sh" ] ||
            [ ! -f "/mnt/SDCARD/System/usr/miyoo/scripts/evtest" ]; then
            echo "One or more required files are missing."
            /mnt/SDCARD/System/bin/7zz -aoa x "$UPDATE_FILE" \
                -o"/mnt/SDCARD" \
                -i"!System/bin/*" \
                -i"!System/lib/*" \
                -i"!System/resources/*" \
                -i"!System/usr/miyoo/scripts/*" \
                -i"!miyoo/res/surwish-os/*"
            sync
        fi

        button=$(infoscreen.sh -m "Surwish-OS update v$update_version found. Press A to install, B to cancel." -k "A B")
        if [ "$button" = "A" ]; then
            /mnt/SDCARD/System/bin/7zz e "$UPDATE_FILE" "System/usr/miyoo/scripts/Surwish_update.sh" -o/tmp -y
            chmod a+x "/tmp/surwish_update.sh"
            cp /mnt/SDCARD/System/bin/text_viewer /tmp
            infoscreen.sh -m "Updating Surwish to v$update_version" -t 1
            pkill -9 preload.sh
            pkill -9 runmiyoo.sh
            /tmp/text_viewer -s "/tmp/Surwish_update.sh" -f 25 -t "                            Surwish-OS Update v$update_version                                      "
        fi
    else
        echo "The Surwish update version ($update_version) is not greater than the current version ($initial_version)."
    fi
else
    echo "No Surwish update file found."
fi
