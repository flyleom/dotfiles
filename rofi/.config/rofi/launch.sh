#!/usr/bin/env bash
set -euo pipefail

setup_config() {
  local resolution=""
  local config_file=""

  # 检查当前 WM 并获取分辨率
  if [ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]; then
    # if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
    resolution=$(hyprctl monitors | awk '/^[[:space:]]*[0-9]+x[0-9]+@/ {print $1; exit}' | cut -d'@' -f1)

    case "$resolution" in
    "3840x2160")
      config_file="$HOME/.config/rofi/config-hypr-4k.rasi"
      ;;
    "1920x1080")
      config_file="$HOME/.config/rofi/config-hypr-1080p.rasi"
      ;;
    *)
      config_file="$HOME/.config/rofi/config.rasi"
      ;;
    esac

  elif [ -n "${SWAYSOCK:-}" ]; then
    # elif [ -n "$SWAYSOCK" ]; then
    # 这里简单使用 grep 提取第一个匹配的分辨率，具体情况可根据 swaymsg 输出调整
    resolution=$(swaymsg -t get_outputs | grep -oE '[0-9]+x[0-9]+' | head -n1)

    case "$resolution" in
    "3840x2160")
      config_file="$HOME/.config/rofi/config-sway-4k.rasi"
      ;;
    "1920x1080")
      config_file="$HOME/.config/rofi/config-sway-1080p.rasi"
      ;;
    *)
      config_file="$HOME/.config/rofi/config.rasi"
      ;;
    esac

  elif command -v i3-msg >/dev/null 2>&1; then
    # i3wm 检测：使用 xrandr 获取当前分辨率（需在 X 环境下）
    resolution=$(xrandr | awk '/\*/ {print $1; exit}')

    case "$resolution" in
    "3840x2160")
      config_file="$HOME/.config/rofi/config-i3-4k.rasi"
      ;;
    "1920x1080")
      config_file="$HOME/.config/rofi/config-i3-1080p.rasi"
      ;;
    *)
      config_file="$HOME/.config/rofi/config.rasi"
      ;;
    esac

  else
    resolution=""
    config_file="$HOME/.config/rofi/config.rasi"

  fi

  echo "$config_file"
}

CONFIG_FILE=$(setup_config)

# Launch Rofi
rofi -show drun -config "$CONFIG_FILE"
