#!/bin/sh
cd $(dirname "$0")

export LD_LIBRARY_PATH=$(dirname "$0")/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=lib:/usr/miyoo/lib:/usr/lib:/mnt/SDCARD/System/lib:LD_LIBRARY_PATH
./DinguxCommander

