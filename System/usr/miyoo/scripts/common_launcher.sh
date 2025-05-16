echo "===================="
echo "$0 $*"

#Find the Emulator directory (first Emu/ subdirectory)
EMU_DIR="$(echo "$0" | sed -E 's|(.*Emu/[^/]+)/.*|\1|')"
PM_DIR="/mnt/SDCARD/App/PortMaster/PortMaster"

export PATH="/mnt/SDCARD/System/usr/miyoo/scripts/:/mnt/SDCARD/System/bin:$PM_DIR:${PATH:+:$PATH}"
export LD_LIBRARY_PATH="/usr/miyoo/lib:/mnt/SDCARD/System/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

dir=/mnt/SDCARD/System/usr/miyoo/scripts

if grep -q ra64.miyoo "$0"; then
    RA_DIR="/mnt/SDCARD/RetroArch"
    export PATH=$PATH:$RA_DIR

    source $dir/FolderOverrideFinder.sh

    # ra_audio_switcher.sh
fi

cd "$EMU_DIR"
source $dir/save_launcher.sh
