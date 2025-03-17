#!/usr/bin/env bash

# 获取主显示器的分辨率
RESOLUTION=$(xrandr | grep '*' | awk '{print $1}')

if [ "$RESOLUTION" = "3840x2160" ]; then
  CONFIG_FILE=$HOME/.config/kitty/kitty_4k.conf
elif [ "$RESOLUTION" = "1920x1080" ]; then
  CONFIG_FILE=$HOME/.config/kitty/kitty_1080.conf
else
  CONFIG_FILE=$HOME/.config/kitty/kitty.conf
fi

# Launch kitty
kitty -c $CONFIG_FILE
