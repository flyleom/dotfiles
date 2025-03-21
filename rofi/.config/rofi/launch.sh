#!/usr/bin/env bash

# 获取主显示器的分辨率
# RESOLUTION=$(xrandr | grep '*' | awk '{print $1}')

RESOLUTION=$(hyprctl monitors | awk '/^[[:space:]]*[0-9]+x[0-9]+@/ {print $1; exit}' | cut -d'@' -f1)

if [ "$RESOLUTION" = "3840x2160" ]; then
  CONFIG_FILE=$HOME/.config/rofi/config_4k.rasi
else
  CONFIG_FILE=$HOME/.config/rofi/config_1080.rasi
fi

# 启动 rofi
rofi -show drun -config $CONFIG_FILE
