#!/usr/bin/env bash

WALLPAPERS=/home/klassm/Bilder/wallpaper
PIC="$(find ${WALLPAPERS} -type f -name *.jpg | shuf -n 1)"
echo $1
if [ ! -z "$1" ]; then
  PIC=$1
fi

H=$(date +%H)
#if (( 8 <= 10#$H && 10#$H < 16 )); then 
#    echo "don't switch, office hours"
#    exit 0
#fi
date
echo "chose ${PIC}"
feh --bg-fill "${PIC}"
