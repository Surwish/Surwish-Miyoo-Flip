#!/bin/sh

MAINSDROOT="$(dirname "$0")/../.."
ROMROOT="$(dirname "$1")/../.."
ROMNAME="$1"
BASEEMU=$(dirname "$0")

    cd $MAINSDROOT/Emu/PORT32
    mount -t squashfs miyoo355_rootfs_32.img mnt
    mount --bind /sys mnt/sys
    mount --bind /dev mnt/dev
    mount --bind /proc mnt/proc
    mount --bind /var/run mnt/var/run
    mount --bind "$MAINSDROOT/" mnt/sdcard
    if [[ "$ROMNAME" == *"sdcard1"* ]]; then
    mount --bind "$ROMROOT" mnt/media/sdcard1
    fi
    mount --bind "$MAINSDROOT/RetroArch/.retroarch/system" mnt/sdcard/RetroArch32/.retroarch/system
    mount --bind "$MAINSDROOT/RetroArch/.retroarch/shaders" mnt/sdcard/RetroArch32/.retroarch/shaders
    mount --bind "$MAINSDROOT/RetroArch/.retroarch/saves" mnt/sdcard/RetroArch32/.retroarch/saves
    mount --bind "$MAINSDROOT/RetroArch/.retroarch/assets" mnt/sdcard/RetroArch32/.retroarch/assets
    mount --bind "$MAINSDROOT/RetroArch/.retroarch/cheats" mnt/sdcard/RetroArch32/.retroarch/cheats
    mount --bind "$MAINSDROOT/RetroArch/.retroarch/autoconfig" mnt/sdcard/RetroArch32/.retroarch/autoconfig
    chroot mnt /bin/sh -c "/mnt/sdcard/Emu/${BASEEMU##*/}/run '$1' '$2' '$3'"
    umount mnt/sdcard/RetroArch32/.retroarch/system
    umount mnt/sdcard/RetroArch32/.retroarch/shaders
    umount mnt/sdcard/RetroArch32/.retroarch/saves
    umount mnt/sdcard/RetroArch32/.retroarch/assets
    umount mnt/sdcard/RetroArch32/.retroarch/cheats
    umount mnt/sdcard/RetroArch32/.retroarch/autoconfig
    umount mnt/sdcard/
    umount mnt/media/sdcard1
    umount mnt/var/run
    umount mnt/proc
    umount mnt/sys
    umount mnt/dev
    umount mnt
