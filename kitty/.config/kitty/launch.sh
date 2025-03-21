#!/usr/bin/env bash

# 获取主显示器的分辨率
# RESOLUTION=$(xrandr | grep '*' | awk '{print $1}')

RESOLUTION=$(hyprctl monitors | awk '/^[[:space:]]*[0-9]+x[0-9]+@/ {print $1; exit}' | cut -d'@' -f1)

if [ "$RESOLUTION" = "3840x2160" ]; then
  CONFIG_FILE=$HOME/.config/kitty/kitty_4k.conf
elif [ "$RESOLUTION" = "1920x1080" ]; then
  CONFIG_FILE=$HOME/.config/kitty/kitty_1080.conf
else
  CONFIG_FILE=$HOME/.config/kitty/kitty.conf
fi

# Launch kitty
kitty -c $CONFIG_FILE
