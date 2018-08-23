#!/bin/sh
set -eu

SCRIPT="$(basename $0)"

notify() {
    echo $1
    notify-send -a "${SCRIPT}" -u low -t 1500 "$1"
}

state=
case $(xset q | grep -i "DPMS is ") in
    *[eE]nabled*)
        echo "Current screen blanking state: enabled"
        state="enabled"
        ;;
    *[dD]isabled*)
        echo "Current screen blanking state: DISABLED"
        state="disabled"
        ;;
esac

active_window_id=$(xprop -root _NET_ACTIVE_WINDOW | cut -d ' ' -f 5)
if [ -n ${active_window_id} ] && xprop -id ${active_window_id} _NET_WM_STATE 2> /dev/null | grep -i "fullscreen" > /dev/null; then
    echo "Active window is in fullscreen state"
    if [ ${state} = "enabled" ]; then
        xset s off -dpms
        xautolock -disable

        active_window_name=$(xprop -id ${active_window_id} WM_CLASS | cut -d '"' -f 4)
        #notify "Disabled screen blanking - '${active_window_name}' in fullscreen"
    fi
elif [ ${state} = "disabled" ]; then
    echo "Active window is not in fullscreen state -> Enable screen blanking"
    xset s on +dpms
    xautolock -enable

    #notify "Re-enabled screen blanking"
fi
