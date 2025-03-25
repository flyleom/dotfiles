#!/usr/bin/env bash
set -euo pipefail

get_config_files() {
  local res="$1"

  case "$res" in
  "3840x2160")
    CONFIG_FILE="$HOME/.config/rofi/config-4k.rasi"
    ;;

  "1920x1080")
    CONFIG_FILE="$HOME/.config/rofi/config-1080p.rasi"
    ;;

  *)
    CONFIG_FILE="$HOME/.config/rofi/config.rasi"
    ;;
  esac
}

# 检查当前 WM 并获取分辨率
if [ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]; then
  # if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
  RESOLUTION=$(hyprctl monitors | awk '/^[[:space:]]*[0-9]+x[0-9]+@/ {print $1; exit}' | cut -d'@' -f1)

elif [ -n "${SWAYSOCK:-}" ]; then
  # elif [ -n "$SWAYSOCK" ]; then
  # 这里简单使用 grep 提取第一个匹配的分辨率，具体情况可根据 swaymsg 输出调整
  RESOLUTION=$(swaymsg -t get_outputs | grep -oE '[0-9]+x[0-9]+' | head -n1)

else
  RESOLUTION=""
fi

# 根据 WM 和分辨率设置配置文件和样式文件
get_config_files "$RESOLUTION"

# Launch Rofi
rofi -show drun -config "$CONFIG_FILE"
