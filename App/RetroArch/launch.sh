#!/bin/sh
echo $0 $*

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$progdir

RA_DIR=/mnt/SDCARD/RetroArch
cd $RA_DIR/

HOME=$RA_DIR/ $RA_DIR/ra64.miyoo -v
