for i in /mnt/SDCARD/Themes/**/config.json; do
    if [ ! -f "$i".bck ]; then
      cp "$i" "$i".bck
    fi
    sed -i 's/"content_font1":[0-9]*/"content_font1":24/' "$i"
done

/mnt/SDCARD/System/usr/miyoo/scripts/mainui_state_update.sh "TITLES FONTSIZE" "24"
