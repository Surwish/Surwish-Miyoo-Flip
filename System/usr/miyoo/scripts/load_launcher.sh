export PATH="/mnt/SDCARD/System/usr/trimui/scripts/:/mnt/SDCARD/System/bin:${PATH:+:$PATH}"
export LD_LIBRARY_PATH="/usr/trimui/lib:${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

EMU_DIR="$(echo "$0" | sed -E 's|(.*Emu/[^/]+)/.*|\1|')"
export ROM_DIR="$(echo "$1" | sed -E 's|(.*Roms/[^/]+)/.*|\1|')"
export GAME=$(basename "$1")

Game_cfg="$ROM_DIR/.games_config/${GAME%.*}.cfg"
Emu_cfg="$EMU_DIR/launchers.cfg"

# Look for a saved preset
if [ -f "$Game_cfg" ]; then
    Launcher_filename=$(cat "$Game_cfg")
	echo "Game launcher override found: $Launcher_filename"
elif [ -f "$Emu_cfg" ]; then
    Launcher_filename=$(cat "$Emu_cfg")
	echo "Console launcher override found: $Launcher_filename"
fi
Launcher_filename=${Launcher_filename#*=}

if [ ! -n "$Launcher_filename" ] || [ ! -f "$EMU_DIR/$Launcher_filename" ] ; then

    # Look for the first valid launcher in launchlist
    if jq -e ".launchlist" "$EMU_DIR/config.json" >/dev/null 2>&1; then
        while read launcher; do
            Launcher_filename=$(echo "$launcher" | jq -r '.launch')
            if [ -n "$Launcher_filename" ]; then break; fi
        done < <(jq -c '.launchlist[]' "$EMU_DIR/config.json")
		echo "No launcher override found, we take the first one: $Launcher_filename"
    else
        # Else use launch.sh as fallback
        Launcher_filename="launch.sh"
		echo "No launcher found, fallback to: $Launcher_filename"
    fi
fi

echo "load_launcher.sh : $Launcher_filename dowork 0x" #>>/tmp/log/messages
"$EMU_DIR/$Launcher_filename" "$@"
