#!/bin/bash
BASE=$0
CORETEMP=${BASE##*/}
CORE=${CORETEMP%%.*}
FULLMODE=1

$(dirname $0)/launch_32.sh "$1" "$CORE" "$FULLMODE"

