#!/bin/sh
echo $0 $*
progdir=`dirname "$0"`/drastic
cd $progdir
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$progdir

echo "=============================================="
echo "==================== DRASTIC  ================="
echo "=============================================="

/mnt/SDCARD/System/usr/miyoo/scripts/cpufreq.sh performance 4 7

export HOME=/mnt/SDCARD
#export SDL_AUDIODRIVER=dsp
# export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$PWD/lib"
# export LD_PRELOAD="./libSDL2-2.0.so.0.2600.1"

./drastic_nn "$*"
