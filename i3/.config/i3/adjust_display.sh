#!/bin/bash

# 获取主显示器的分辨率
RESOLUTION=$(xrandr | grep '*' | awk '{print $1}')

case "$RESOLUTION" in
"3840x2160")
  # 4K 分辨率，设置 DPI 200%，调整 i3 相关配置
  xrandr --output HDMI-1 --mode 3840x2160
  xrdb -merge <<<"Xft.dpi: 192"
  feh --bg-scale $HOME/repo/wallpaper/Pictures/wallpaper/3840x2160/wallhaven-39yr8y_3840x2160.png
  ;;
"1920x1080")
  # 1080p 分辨率，设置 DPI 150%
  xrandr --output HDMI-1 --mode 1920x1080
  xrdb -merge <<<"Xft.dpi: 144"
  feh --bg-scale $HOME/repo/wallpaper/Pictures/wallpaper/1920×1080/wallhaven-39yr8y_1920x1080.png
  ;;
*)
  # "未匹配到特定分辨率，使用默认设置"
  xrandr --output HDMI-1 --mode 1920x1080
  xrdb -merge <<<"Xft.dpi: 96"
  ;;
esac
