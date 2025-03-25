#!/usr/bin/env bash
set -euo pipefail

get_config_files() {
  local wm="$1"
  local res="$2"

  case "$wm" in
  hyprland)
    case "$res" in
    "3840x2160")
      CONFIG_FILE="$HOME/.config/waybar/waybar-hypr-4k/config.jsonc"
      STYLE_FILE="$HOME/.config/waybar/waybar-hypr-4k/style.css"
      ;;
    "1920x1080")
      CONFIG_FILE="$HOME/.config/waybar/waybar-hypr-1080p/config.jsonc"
      STYLE_FILE="$HOME/.config/waybar/waybar-hypr-1080p/style.css"
      ;;
    *)
      CONFIG_FILE="$HOME/.config/waybar/config.jsonc"
      STYLE_FILE="$HOME/.config/waybar/style.css"
      ;;
    esac
    ;;

  sway)
    case "$res" in
    "3840x2160")
      CONFIG_FILE="$HOME/.config/waybar/waybar-sway-4k/config.jsonc"
      STYLE_FILE="$HOME/.config/waybar/waybar-sway-4k/style.css"
      ;;
    "1920x1080")
      CONFIG_FILE="$HOME/.config/waybar/waybar-sway-1080p/config.jsonc"
      STYLE_FILE="$HOME/.config/waybar/waybar-sway-1080p/style.css"
      ;;
    *)
      CONFIG_FILE="$HOME/.config/waybar/config.jsonc"
      STYLE_FILE="$HOME/.config/waybar/style.css"
      ;;
    esac
    ;;

  *)
    # 如果无法判断 WM，使用默认配置
    CONFIG_FILE="$HOME/.config/waybar/config.jsonc"
    STYLE_FILE="$HOME/.config/waybar/style.css"
    ;;
  esac
}

# 检查当前 WM 并获取分辨率
if [ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]; then
  # if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
  WM="hyprland"
  RESOLUTION=$(hyprctl monitors | awk '/^[[:space:]]*[0-9]+x[0-9]+@/ {print $1; exit}' | cut -d'@' -f1)

elif [ -n "${SWAYSOCK:-}" ]; then
  # elif [ -n "$SWAYSOCK" ]; then
  WM="sway"
  # 这里简单使用 grep 提取第一个匹配的分辨率，具体情况可根据 swaymsg 输出调整
  RESOLUTION=$(swaymsg -t get_outputs | grep -oE '[0-9]+x[0-9]+' | head -n1)

else
  WM="unknown"
  RESOLUTION=""
fi

# 根据 WM 和分辨率设置配置文件和样式文件
get_config_files "$WM" "$RESOLUTION"

# 启动 waybar
waybar -c "$CONFIG_FILE" -s "$STYLE_FILE"
