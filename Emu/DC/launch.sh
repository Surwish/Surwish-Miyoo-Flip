#!/bin/sh
echo $0 $*
progdir=`dirname "$0"`
cd $progdir
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$progdir/lib

echo "=============================================="
echo "==================== flycast ================="
echo "=============================================="

$progdir./cpufreq.sh
$progdir./cpuswitch.sh

export HOME=$progdir
#export SDL_AUDIODRIVER=dsp
./flycast "$*"
