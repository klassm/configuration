#!/usr/bin/env bash

WALLPAPERS=/home/klassm/Bilder/wallpaper
PIC="$(find ${WALLPAPERS} -type f | shuf -n 1)"

echo "chose ${PIC}"
feh --bg-scale "${PIC}"
