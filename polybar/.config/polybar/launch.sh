#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# pkill -f polybar

# Wait until the processes have been shut down
# while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

./adjust_polybar.sh
# Launch polybar
polybar -q -c $HOME/.config/polybar/config.ini &
