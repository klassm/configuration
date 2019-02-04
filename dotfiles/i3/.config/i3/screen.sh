#!/usr/bin/env bash

case "$1" in
  augsburg)
    ~/.screenlayout/augsburg.sh
    ;;
  *)
    python3 ~/.screenlayout/display.py "$1"
esac

~/.config/i3/random_wallpaper.sh
