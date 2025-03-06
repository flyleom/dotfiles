#!/bin/bash

# 获取主显示器的分辨率
RESOLUTION=$(xrandr | grep '*' | awk '{print $1}')
CONFIG_TEMPLATE=$HOME/.config/polybar/config.ini.template
CONFIG_FILE=$HOME/.config/polybar/config.ini

# 复制模板文件（防止 `git` 受影响）
cp "$CONFIG_TEMPLATE" "$CONFIG_FILE"

# 根据分辨率调整 DPI
if [ "$RESOLUTION" = "3840x2160" ]; then
  DPI=192
elif [ "$RESOLUTION" = "2560x1440" ]; then
  DPI=144
else
  DPI=96
fi

# 修改 `dpi` 配置
sed -i "s/^dpi = .*/dpi = $DPI/" "$CONFIG_FILE"
