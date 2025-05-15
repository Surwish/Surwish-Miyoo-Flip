killall -9 MainUI
killall -9 keymon
killall -9 btmanager
killall -9 hardwareservice
killall -9 miyoo_inputd

/usr/bin/fbdisplay /usr/miyoo/bin/skin/icon-remove-sd-card.png &

sdcardpath=`mount | grep "/mnt/sdcard" | cut -d" " -f1`
umount -l /mnt/sdcard/
umount -l /media/sdcard0/
if [ "$sdcardpath" != "" ] ; then
    #umount $sdcardpath
    fsck.vfat -a $sdcardpath
fi

sdcardpath=`mount | grep "/media/sdcard1" | cut -d" " -f1`
umount -l /media/sdcard1/
if [ "$sdcardpath" != "" ] ; then
    umount $sdcardpath
    fsck.vfat -a $sdcardpath
fi

touch /tmp/fbdisplay_exit