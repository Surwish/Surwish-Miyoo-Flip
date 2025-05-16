#!/bin/sh
MAINSDROOT="$(dirname $0)/../.."
ROMROOT="$(dirname $1)/../.."
ROMNAME="$1"
BASEROMNAME=${ROMNAME##*/}
ROMNAMETMP=${BASEROMNAME%.*}
ROMPATH=${ROMNAME%.*}
    cd $(dirname $0)
    mount -t squashfs miyoo355_rootfs_32.img mnt
    mount --bind /sys mnt/sys
    mount --bind /dev mnt/dev
    mount --bind /proc mnt/proc
    mount --bind /var/run mnt/var/run
    mount --bind "$MAINSDROOT/" mnt/sdcard
    if [[ "$ROMNAME" == *"sdcard1"* ]]; then
    mount --bind "$ROMROOT" mnt/media/sdcard1
    fi
    chroot mnt /bin/sh -c "${ROMNAME}"
    umount mnt/sdcard
    umount mnt/media/sdcard1
    umount mnt/var/run
    umount mnt/proc
    umount mnt/sys
    umount mnt/dev
    umount mnt
