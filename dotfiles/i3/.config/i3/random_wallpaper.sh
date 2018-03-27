#!/usr/bin/env bash

WALLPAPERS=/home/klassm/Bilder/wallpaper
PIC="$(find ${WALLPAPERS} -type f | shuf -n 1)"

date
echo "chose ${PIC}"
DISPLAY=:0 feh --bg-scale "${PIC}"
