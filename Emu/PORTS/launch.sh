#!/bin/sh
source /mnt/SDCARD/System/usr/miyoo/scripts/common_launcher.sh
source /mnt/SDCARD/System/etc/ex_config


selected_mode=$(grep "dowork 0x" "/tmp/log/messages" | tail -n 1 | sed -e 's/.*: \(.*\) dowork 0x.*/\1/')
case "$selected_mode" in
"High Performance")
	cpufreq.sh performance 2 7
	;;
"Battery Saver")
	cpufreq.sh conservative 2 4
	;;
*)
	cpufreq.sh ondemand 2 6
	;;
esac

cd /mnt/SDCARD/Roms/PORTS

export directory="$ROM_DIR"
export LD_LIBRARY_PATH="/mnt/SDCARD/System/lib:$LD_LIBRARY_PATH"
export PATH="/mnt/SDCARD/System/bin:${PATH:+:$PATH}"
export XDG_DATA_HOME="/mnt/SDCARD/App/PortMaster"



# umount /userdata/rootfs32/sys
# umount /userdata/rootfs32/dev
# umount /userdata/rootfs32/proc
# umount /userdata/rootfs32/var/run
# umount /userdata/rootfs32/SDCARD
# umount /userdata/rootfs32


# env directory="$ROM_DIR" \
    # HOME="/userdata" \
    # LD_LIBRARY_PATH="/usr/lib32:/mnt/SDCARD/System/lib32:$LD_LIBRARY_PATH" \
    # PATH="/mnt/SDCARD/System/bin:${PATH:+:$PATH}" \
    # XDG_DATA_HOME="/mnt/SDCARD/App/PortMaster" \
    # chroot /userdata/rootfs32 /bin/sh -c "$@"
HOME=/userdata /bin/sh "$@"



# chroot /mnt/SDCARD/Emu/PORT32/mnt /bin/sh -c 'HOME="/userdata" LD_LIBRARY_PATH=/mnt/sdcard/Emu/PORT32/mnt/usr/lib:/mnt/sdcard/App/am2r/libs /mnt/sdcard/App/am2r/gmloader /mnt/sdcard/App/am2r/gamedata/am2r.apk'
# chroot /userdata/rootfs32 /bin/sh



# XDG_DATA_HOME="/mnt/SDCARD/App/PortMaster"  LD_LIBRARY_PATH="/mnt/SDCARD/System/lib32:$LD_LIBRARY_PATH"   /mnt/SDCARD/Roms/PORTS/Maldita\ Castilla.sh