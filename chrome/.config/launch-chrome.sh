#!/bin/bash
# 检查是否连接了4K屏幕（分辨率3840x2160），你可以根据实际情况调整判断条件
if xrandr | grep -q "3840x2160"; then
  scale=2
else
  scale=1
fi

exec google-chrome-stable --force-device-scale-factor=$scale "$@"
