#!/bin/sh
source /mnt/SDCARD/System/usr/miyoo/scripts/update_common.sh

run_bootstrap() {
	curl -k -s https://raw.githubusercontent.com/$GITHUB_REPOSITORY/main/_assets/scripts/ota_bootstrap.sh | sh
}

main() {
	check_connection
	sleep 2
	clear
	run_bootstrap
	clear

	echo -e "\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n" >>"$updatedir/ota_release.log"
	echo -e "${timestamp}\n" >>"$updatedir/ota_release.log"
	/mnt/SDCARD/System/usr/miyoo/scripts/update_ota_release.sh | tee -a "$updatedir/ota_release.log"

	# if there is no release to apply, we check if there is hotfix for this version
	if grep -q -E "^(no release|user cancel)$" "/tmp/ota_release_result"; then # "no release", "user cancel", "download failed", "success"
		url="https://raw.githubusercontent.com/$GITHUB_REPOSITORY/main/_assets/hotfixes/Surwish-OS_v$Local_SurwishVersion.sh"

		if /mnt/SDCARD/System/bin/wget -q --spider "$url"; then

			echo -e "\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n" >>"$updatedir/ota_hotfix.log"
			echo -e "${timestamp}\n" >>"$updatedir/ota_hotfix.log"
			curl -k -s "$url" | sh | tee -a "$updatedir/ota_hotfix.log"

		else
			clear
			echo -ne "${PURPLE}Retrieving hotfix information... ${NC}"
			echo -ne "${GREEN}DONE${NC}\n\n\n"
			echo -e "No hotfix available for Surwish v$Local_SurwishVersion.\n"
			echo -ne "${YELLOW}"
			read -n 1 -s -r -p "Press A to exit"
		fi
	fi
	sleep 2
	# killall -2 SimpleTerminal

}

main
