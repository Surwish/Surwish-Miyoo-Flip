#!/bin/sh
export LD_LIBRARY_PATH="/mnt/SDCARD/System/lib:/usr/miyoo/lib:$LD_LIBRARY_PATH"

################ Surwish-OS Version Splashscreen ################

read -r version </mnt/SDCARD/System/usr/miyoo/surwish-version.txt
/mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -i "$Current_bg" -m "Surwish OS v$version"
read -r FW_patched_version </userdata/surwish-version.txt

extract_and_cleanup() {
    ARCHIVE_PATH="$1"
    DEST_DIR="$2"
    BIN="/mnt/SDCARD/System/bin/7zz"

    "$BIN" x -aoa "$ARCHIVE_PATH" -o"$DEST_DIR"
    if [ $? -eq 0 ]; then
        echo "Extraction successful. Removing archive parts..."
        ARCHIVE_BASENAME="$(basename "$ARCHIVE_PATH")"
        ARCHIVE_DIR="$(dirname "$ARCHIVE_PATH")"

        # Strip .7z or .7z.001 to get the base name
        BASE="${ARCHIVE_BASENAME%.001}"
        BASE="${BASE%.7z}"

        # Remove .7z, .7z.001, .7z.002, etc.
        rm -f "$ARCHIVE_DIR/$BASE.7z"*
    else
        echo "Extraction failed. Archive files have not been removed."
    fi
}

if [ "$version" != "$FW_patched_version" ]; then

    # Extract 32bits rootFS
    extract_and_cleanup "/mnt/SDCARD/Emu/PORT32/miyoo355_rootfs_32.7z.001" "/mnt/SDCARD/Emu/PORT32"

    # Extract cores
    for archive in /mnt/SDCARD/RetroArch/.retroarch/cores/*.7z /mnt/SDCARD/RetroArch/.retroarch/cores/*.7z.001; do
        [ -e "$archive" ] || continue # Skip if no match
        extract_and_cleanup "$archive" "/mnt/SDCARD/RetroArch/.retroarch/cores/"
    done
	
    echo $version >/userdata/surwish-version.txt

fi

killall -9 infoscreen.sh
