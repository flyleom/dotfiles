#!/bin/bash

# 获取主显示器的分辨率
RESOLUTION=$(xrandr | grep '*' | awk '{print $1}')

case "$RESOLUTION" in
"3840x2160")
  # feh --bg-scale $HOME/repo/wallpaper/Pictures/wallpaper/3840x2160/wallhaven-39yr8y_3840x2160.png
  feh --bg-scale --no-fehbg --randomize $HOME/repo/wallpaper/Pictures/wallpaper/3840x2160
  ;;
"1920x1080")
  # feh --bg-scale $HOME/repo/wallpaper/Pictures/wallpaper/1920×1080/wallhaven-39yr8y_1920x1080.png
  feh --bg-scale --no-fehbg --randomize $HOME/repo/wallpaper/Pictures/wallpaper/1920×1080
  ;;
*)
  # "未匹配到特定分辨率，使用默认设置"
  feh --bg-scale --no-fehbg --randomize $HOME/repo/wallpaper/Pictures/wallpaper/1920×1080
  ;;
esac
