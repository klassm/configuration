#!/usr/bin/env bash

WALLPAPERS=/home/klassm/Bilder/wallpaper
PIC="$(find ${WALLPAPERS} -type f | shuf -n 1)"

H=$(date +%H)
#if (( 8 <= 10#$H && 10#$H < 16 )); then 
#    echo "don't switch, office hours"
#    exit 0
#fi
date
echo "chose ${PIC}"
DISPLAY=:0 feh --bg-scale "${PIC}"
