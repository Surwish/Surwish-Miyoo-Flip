#!/bin/sh
export LD_LIBRARY_PATH="/mnt/SDCARD/System/lib:/usr/trimui/lib:$LD_LIBRARY_PATH"
system_json="/mnt/UDISK/system.json"
Current_Theme=$(/usr/trimui/bin/systemval theme)
Current_bg="$Current_Theme/skin/bg.png"
if [ ! -f "$Current_bg" ]; then
	Current_bg="/mnt/SDCARD/trimui/res/skin/transparent.png"
fi

read -r device_type </tmp/device_type

################ CrossMix-OS Version Splashscreen ################

read -r version </mnt/SDCARD/System/usr/trimui/crossmix-version.txt
/mnt/SDCARD/System/usr/trimui/scripts/infoscreen.sh -i "$Current_bg" -m "CrossMix OS v$version"

################ CrossMix-OS internal storage Customization ################
read -r FW_patched_version </usr/trimui/crossmix-version.txt

if [ "$version" != "$FW_patched_version" ]; then

	# trimui_inputd update

	Current_FW_Revision=$(grep 'DISTRIB_DESCRIPTION' /etc/openwrt_release | cut -d '.' -f 3)
	if [ "$device_type" = "tsp" ]; then

		Max_FW_Revision="20240503"

		if [ "$Current_FW_Revision" -le "$Max_FW_Revision" ]; then

			Sha_expected_1ms=21b1f3e38ca856e973970fec9fa4c17286ab7e85
			Sha_expected_8ms=398f160580207e239a45759cd5f7df8f3d587248
			Sha_expected_16ms=11ceb2d5bb46eaa7e1880d4db6c756d6a77658f6
			Sha_1ms=$(sha1sum /mnt/SDCARD/System/resources/trimui_inputd/1ms | cut -d ' ' -f 1)
			Sha_8ms=$(sha1sum /mnt/SDCARD/System/resources/trimui_inputd/8ms | cut -d ' ' -f 1)
			Sha_16ms=$(sha1sum /mnt/SDCARD/System/resources/trimui_inputd/16s | cut -d ' ' -f 1)
			if [ "$Sha_expected_1ms" = "$Sha_1ms" ] && [ "$Sha_expected_8ms" = "$Sha_8ms" ] &&
				[ "$Sha_expected_16ms" = "$Sha_16ms" ]; then

				if [ ! -f /usr/trimui/bin/trimui_inputd.bak ]; then
					mv /usr/trimui/bin/trimui_inputd /usr/trimui/bin/trimui_inputd.bak
				fi

				cp /mnt/SDCARD/System/resources/trimui_inputd/1ms /usr/trimui/bin/trimui_inputd.1ms
				cp /mnt/SDCARD/System/resources/trimui_inputd/8ms /usr/trimui/bin/trimui_inputd.8ms
				cp /mnt/SDCARD/System/resources/trimui_inputd/16ms /usr/trimui/bin/trimui_inputd.16ms
				cp /mnt/SDCARD/System/resources/trimui_inputd/16ms /usr/trimui/bin/trimui_inputd

				chmod +x /usr/trimui/bin/trimui_inputd.1ms
				chmod +x /usr/trimui/bin/trimui_inputd.8ms
				chmod +x /usr/trimui/bin/trimui_inputd.16ms
				chmod +x /usr/trimui/bin/trimui_inputd

				cp /mnt/SDCARD/System/resources/preload.sh /usr/trimui/bin/preload.sh
			else
				/mnt/SDCARD/System/usr/trimui/scripts/infoscreen.sh -m "Not able to update trimui_inputd, at least one new is missing or corrupted"
			fi

		else

			echo "recent firmware: trimui_inputd will not be updated"

		fi

		# modifying default theme to impact all other themes (Better game image background)
		# mv "/usr/trimui/res/skin/ic-game-580.png" "/usr/trimui/res/skin/ic-game-580_old.png"
		cp "/mnt/SDCARD/trimui/res/skin/ic-game-580.png" "/usr/trimui/res/skin/ic-game-580.png"
	elif [ "$device_type" = "brick" ]; then

# L1 key = modify D-PAD to Stick
		cp -r "/mnt/SDCARD/System/usr/trimui/fnkeys" "/usr/trimui/"

	fi

	# Removing duplicated app
	rm -rf /usr/trimui/apps/zformatter_fat32/

	# making some place in root fs
	rm -rf /usr/trimui/res/sound/bgm2.mp3
	swapoff -a
	rm -rf /swapfile
	mv /bin/busybox.bak /mnt/SDCARD/System/bin 2>/dev/null
	cp "/mnt/SDCARD/trimui/res/skin/bg.png" "/usr/trimui/res/skin/"

	# Increase alsa sound buffer
	# cp "/mnt/SDCARD/System/usr/trimui/etc/asound.conf" "/etc/asound.conf"

	# add Pl language + Fr and En mods
	if [ ! -e "/usr/trimui/res/skin/pl.lang" ]; then
		cp "/mnt/SDCARD/trimui/res/lang/"*.lang "/usr/trimui/res/lang/"
		cp "/mnt/SDCARD/trimui/res/lang/"*.short "/usr/trimui/res/lang/"
		cp "/mnt/SDCARD/trimui/res/lang/"*.png "/usr/trimui/res/skin/"
	fi

	# custom shutdown script for "Resume at Boot"
	cp "/mnt/SDCARD/System/usr/trimui/bin/kill_apps.sh" "/usr/trimui/bin/kill_apps.sh"
	chmod a+x "/usr/trimui/bin/kill_apps.sh"

	# fix retroarch path for PortMaster
	cp "/mnt/SDCARD/System/usr/trimui/bin/retroarch" "/usr/bin/retroarch"
	chmod a+x "/usr/bin/retroarch"

	# custom shutdown script, will be called by MainUI
	# cp "/mnt/SDCARD/System/bin/shutdown" "/usr/bin/poweroff"
	# chmod a+x "/usr/bin/poweroff"

	# modifying FN cpu script (don't force slow cpu, only force high speed when FN is set to ON) (and we set it as default)
	cp /mnt/SDCARD/System/usr/trimui/res/apps/fn_editor/com.trimui.cpuperformance.sh /usr/trimui/apps/fn_editor/com.trimui.cpuperformance.sh
	cp /mnt/SDCARD/System/usr/trimui/res/apps/fn_editor/com.trimui.cpuperformance.sh /usr/trimui/scene/com.trimui.cpuperformance.sh

	# Apply default CrossMix theme, sound volume, and grid view
	if [ ! -f /mnt/UDISK/system.json ]; then
		cp /mnt/SDCARD/System/usr/trimui/scripts/MainUI_default_system.json /mnt/UDISK/system.json
	else
		/usr/trimui/bin/systemval theme "/mnt/SDCARD/Themes/Surwish/"
		/usr/trimui/bin/systemval menustylel1 1
		/usr/trimui/bin/systemval bgmvol 10
	fi

	# modifying performance mode for Moonlight

	if ! grep -qF "performance" "/usr/trimui/apps/moonlight/launch.sh"; then
		sed -i 's|^\./moonlightui|echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor\necho 1608000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq\n\./moonlightui|' /usr/trimui/apps/moonlight/launch.sh
	fi
	# we set the customization flag
	rm "/usr/trimui/fw_mod_done"
	echo $version >/usr/trimui/crossmix-version.txt
	sync

	################ CrossMix-OS SD card Customization ################

	# Sorting Themes Alphabetically
	"/mnt/SDCARD/Apps/SystemTools/Menu/THEME/Sort Themes Alphabetically.sh" -s

	# Game tab by default
	"/mnt/SDCARD/Apps/SystemTools/Menu/USER INTERFACE##START TAB (value)/Tab Game.sh" -s

	# Displaying only Emulators with roms
	/mnt/SDCARD/Apps/EmuCleaner/launch.sh -s

	####################################################################

	################ Flash boot logo ################

	"/mnt/SDCARD/Emus/_BootLogo/launch.sh" "/mnt/SDCARD/Apps/BootLogo/Images_${device_type}/Surwish.bmp"

fi

######################### CrossMix-OS at each boot #########################

################ Branding ################
if [ ! -e "/usr/trimui/branding" ]; then
	if [ -e "/mnt/SDCARD/System/usr/trimui/branding" ]; then
		LOG_FILE="/mnt/SDCARD/System/usr/trimui/branding.log"
		exec >$LOG_FILE 2>&1
		brand=$(cat /mnt/SDCARD/System/usr/trimui/branding | head -n 1)
		if [ -z "$brand" ]; then
			echo "No branding configured."

		else
			cp /mnt/SDCARD/System/usr/trimui/branding /usr/trimui/branding
			# cleaning
			echo cleaning
			brandslist="/mnt/SDCARD/System/usr/trimui/brandslist"
			if [ -f "$brandslist" ]; then
				echo cleaning1
				while IFS= read -r branditem; do
					echo cleaning2
					branditem=$(echo "$branditem" | tr -d '\r')
					if [ -n "$branditem" ] && [ "$branditem" != "$brand" ]; then
						rm -rf "/mnt/SDCARD/Themes/$branditem"
						rm -f "/mnt/SDCARD/Apps/BootLogo/Images_brick/$branditem.bmp"
						rm -f "/mnt/SDCARD/Apps/BootLogo/Images_tsp/$branditem.bmp"

						echo Removing "/mnt/SDCARD/Themes/$branditem, /mnt/SDCARD/Apps/BootLogo/Images_brick/$branditem.bmp  and /mnt/SDCARD/Apps/BootLogo/Images_tsp/$branditem.bmp"
					fi
				done <"$brandslist"
				rm -f "$brandslist"
			fi

			# Apply theme
			/usr/trimui/bin/systemval theme "/mnt/SDCARD/Themes/$brand/"

			# Flash logo

			echo "Flashing logo..."
			"/mnt/SDCARD/Emus/_BootLogo/launch.sh" "/mnt/SDCARD/Apps/BootLogo/Images_${device_type}/$brand.bmp"

		fi

	fi
fi
####################################################################

######################### Device Type customization #########################

read -r previous_device_type </mnt/SDCARD/System/etc/previous_device_type
if [ "$previous_device_type" != "$device_type" ]; then
	echo $device_type >/mnt/SDCARD/System/etc/previous_device_type

	/mnt/SDCARD/System/usr/trimui/scripts/infoscreen.sh -i "$Current_bg" -m "Switching from $previous_device_type to $device_type. "

	#manage different RA versions
	cp "/mnt/SDCARD/RetroArch/ra64.trimui_$device_type" /mnt/SDCARD/RetroArch/ra64.trimui

	#manage theme differences
	themes_dir="/mnt/SDCARD/Themes"
	for theme_folder in "$themes_dir"/*; do
		if [ -d "$theme_folder" ]; then
			source_path="$theme_folder/skin/$device_type"
			destination_path="$theme_folder/skin"
			if [ -d "$source_path" ]; then
				cp -r "$source_path/"* "$destination_path/"
				echo "Copied skin contents from $source_path to $destination_path"
			fi
		fi
	done

	sync

	if [ "$device_type" = "tsp" ]; then
		/mnt/SDCARD/System/usr/trimui/scripts/set_ra_cfg.sh "/mnt/SDCARD/Emus/N64/mupen64plus/mupen64plus.cfg" "ScreenWidth" 1280
		/mnt/SDCARD/System/usr/trimui/scripts/set_ra_cfg.sh "/mnt/SDCARD/Emus/N64/mupen64plus/mupen64plus.cfg" "ScreenHeight" 720

		/mnt/SDCARD/System/usr/trimui/scripts/set_ra_cfg.sh "/mnt/SDCARD/Data/ports/gta3/re3.ini" "Width" 1280
		/mnt/SDCARD/System/usr/trimui/scripts/set_ra_cfg.sh "/mnt/SDCARD/Data/ports/gta3/re3.ini" "Height" 720

		/mnt/SDCARD/System/usr/trimui/scripts/set_ra_cfg.sh "/mnt/SDCARD/Data/ports/gtavc/reVC.ini" "Width" 1280
		/mnt/SDCARD/System/usr/trimui/scripts/set_ra_cfg.sh "/mnt/SDCARD/Data/ports/gtavc/reVC.ini" "Height" 720

		sed -i '/width/d;/height/d' /mnt/SDCARD/Data/ports/Half-Life/valve/video.cfg
		cp /mnt/SDCARD/Data/ports/Half-Life/valve/config_tsp.cfg /mnt/SDCARD/Data/ports/Half-Life/valve/config.cfg

		cp /mnt/SDCARD/Data/ports/quake2/baseq2/config_tsp.cfg /mnt/SDCARD/Data/ports/quake2/baseq2/config.cfg

		cp /mnt/SDCARD/Data/ports/quake3/conf/.q3a/baseq3/q3config_tsp.cfg /mnt/SDCARD/Data/ports/quake3/conf/.q3a/baseq3/q3config.cfg

		cp /mnt/SDCARD/Data/ports/rvgl/profiles/ark/profile_tsp.ini /mnt/SDCARD/Data/ports/rvgl/profiles/ark/profile.ini

		cp /mnt/SDCARD/Data/ports/iortcw/conf/.wolf/main/wolfconfig_tsp.cfg /mnt/SDCARD/Data/ports/iortcw/conf/.wolf/main/wolfconfig.cfg

		cp /mnt/SDCARD/Data/ports/saltandsanctuary/savedata/config_tsp.ini /mnt/SDCARD/Data/ports/saltandsanctuary/savedata/config.ini

		cp /mnt/SDCARD/Data/ports/sonicmania/Settings_tsp.ini /mnt/SDCARD/Data/ports/sonicmania/Settings.ini

		cp /mnt/SDCARD/Data/ports/stardewvalley/savedata/startup_preferences_tsp /mnt/SDCARD/Data/ports/stardewvalley/savedata/startup_preferences

		cp /mnt/SDCARD/Emus/PSP/PPSSPP_1.17.1/PPSSPPSDL_gl_tsp /mnt/SDCARD/Emus/PSP/PPSSPP_1.17.1/PPSSPPSDL_gl

	#################################################################
	elif [ "$device_type" = "brick" ]; then
		/mnt/SDCARD/System/usr/trimui/scripts/set_ra_cfg.sh "/mnt/SDCARD/Emus/N64/mupen64plus/mupen64plus.cfg" "ScreenWidth" 1024
		/mnt/SDCARD/System/usr/trimui/scripts/set_ra_cfg.sh "/mnt/SDCARD/Emus/N64/mupen64plus/mupen64plus.cfg" "ScreenHeight" 768

		/mnt/SDCARD/System/usr/trimui/scripts/set_ra_cfg.sh "/mnt/SDCARD/Data/ports/gta3/re3.ini" "Width" 1024
		/mnt/SDCARD/System/usr/trimui/scripts/set_ra_cfg.sh "/mnt/SDCARD/Data/ports/gta3/re3.ini" "Height" 768

		/mnt/SDCARD/System/usr/trimui/scripts/set_ra_cfg.sh "/mnt/SDCARD/Data/ports/gtavc/reVC.ini" "Width" 1024
		/mnt/SDCARD/System/usr/trimui/scripts/set_ra_cfg.sh "/mnt/SDCARD/Data/ports/gtavc/reVC.ini" "Height" 768

		sed -i '/width/d;/height/d' /mnt/SDCARD/Data/ports/Half-Life/valve/video.cfg
		cp /mnt/SDCARD/Data/ports/Half-Life/valve/config_brick.cfg /mnt/SDCARD/Data/ports/Half-Life/valve/config.cfg

		cp /mnt/SDCARD/Data/ports/quake2/baseq2/config_brick.cfg /mnt/SDCARD/Data/ports/quake2/baseq2/config.cfg

		cp /mnt/SDCARD/Data/ports/quake3/conf/.q3a/baseq3/q3config_brick.cfg /mnt/SDCARD/Data/ports/quake3/conf/.q3a/baseq3/q3config.cfg

		cp /mnt/SDCARD/Data/ports/rvgl/profiles/ark/profile_brick.ini /mnt/SDCARD/Data/ports/rvgl/profiles/ark/profile.ini

		cp /mnt/SDCARD/Data/ports/iortcw/conf/.wolf/main/wolfconfig_brick.cfg /mnt/SDCARD/Data/ports/iortcw/conf/.wolf/main/wolfconfig.cfg

		cp /mnt/SDCARD/Data/ports/saltandsanctuary/savedata/config_brick.ini /mnt/SDCARD/Data/ports/saltandsanctuary/savedata/config.ini

		cp /mnt/SDCARD/Data/ports/sonicmania/Settings_brick.ini /mnt/SDCARD/Data/ports/sonicmania/Settings.ini

		cp /mnt/SDCARD/Data/ports/stardewvalley/savedata/startup_preferences_brick /mnt/SDCARD/Data/ports/stardewvalley/savedata/startup_preferences

		cp /mnt/SDCARD/Emus/PSP/PPSSPP_1.17.1/PPSSPPSDL_gl_brick /mnt/SDCARD/Emus/PSP/PPSSPP_1.17.1/PPSSPPSDL_gl

	fi
fi
sync

# Apply current led configuration
/mnt/SDCARD/System/etc/led_config.sh &
