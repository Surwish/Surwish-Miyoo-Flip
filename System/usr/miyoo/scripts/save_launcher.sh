save_launcher() {
    Emu_cfg="$EMU_DIR/launchers.cfg"
    Launcher_filename=$(awk -F'"' '/chmod a\+x/ { print $2 }' /tmp/cmd_to_run.sh | xargs basename)


    if [ -n "$1" ]; then
        GAME=$(basename "$1")
        Cfg_dir="$ROM_DIR/.games_config"
        mkdir -p "$Cfg_dir"
        Game_cfg="$Cfg_dir/${GAME%.*}.cfg"
        echo "launcher=$Launcher_filename" >"$Game_cfg"
    else
        echo "default_launcher=$Launcher_filename" >"$Emu_cfg"
    fi
}

button_state.sh L
if [ $? -eq 10 ]; then
    save_launcher "$1"
    /mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -m "Emulator override created for ${GAME%.*}" -t 1
fi


# Save launcher as default one
button_state.sh R
if [ $? -eq 10 ]; then
    save_launcher
    /mnt/SDCARD/System/usr/miyoo/scripts/infoscreen.sh -m "Emulator override created for all $(basename $ROM_DIR) games" -t 1
fi

