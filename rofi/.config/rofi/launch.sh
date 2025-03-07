#!/usr/bin/env bash

# 获取主显示器的分辨率
RESOLUTION=$(xrandr | grep '*' | awk '{print $1}')

if [ "$RESOLUTION" = "3840x2160" ]; then
  CONFIG_FILE=$HOME/.config/rofi/config_4k.rasi
else
  CONFIG_FILE=$HOME/.config/rofi/config_1080.rasi
fi

# 启动 rofi
rofi -show drun -config $CONFIG_FILE
