#!/usr/bin/env bash

# 获取主显示器的分辨率
RESOLUTION=$(xrandr | grep '*' | awk '{print $1}')

if [ "$RESOLUTION" = "3840x2160" ]; then
  CONFIG_FILE=$HOME/.config/polybar/config_4k.ini
elif [ "$RESOLUTION" = "1920x1080" ]; then
  CONFIG_FILE=$HOME/.config/polybar/config_1080.ini
else
  CONFIG_FILE=$HOME/.config/polybar/config_1080.ini
fi

# Terminate already running bar instances
killall -q polybar
# pkill -f polybar

# Wait until the processes have been shut down
# while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch polybar
polybar -q -c $CONFIG_FILE &
