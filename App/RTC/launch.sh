#!/bin/sh
SDL_GAMECONTROLLERCONFIG_FILE="./gamecontrollerdb.txt" ./gptokeyb -k "rtc" -c "./rtc.gptk" &
sleep 1
./rtc
kill -9 $(pidof gptokeyb)
