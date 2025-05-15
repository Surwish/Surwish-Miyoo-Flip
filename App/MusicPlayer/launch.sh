#!/bin/sh
export PATH="/mnt/SDCARD/System/bin:/mnt/SDCARD/System/usr/miyoo/scripts:$PATH"

# we disable auto play on GMU start from Apps section
settings_file="/mnt/SDCARD/App/MusicPlayer/gmu.settings.conf"
sed -i 's/^Gmu.AutoPlayOnProgramStart=yes$/Gmu.AutoPlayOnProgramStart=no/' "$settings_file"

first_run_file="/mnt/SDCARD/App/MusicPlayer/FirstRunDone"
radios_archive="/mnt/SDCARD/App/MusicPlayer/Radios.7z"

if [ -f "$radios_archive" ]; then
    infoscreen.sh -m "Extracting radio playlists, please wait..."
    7zz x -aoa "$radios_archive" -o"/mnt/SDCARD/Roms/MUSIC"
    mv "$radios_archive" "/mnt/SDCARD/App/MusicPlayer/Radios_extracted.7z"
fi

sync

./gmu_launcher.sh
