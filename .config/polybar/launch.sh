#!/usr/bin/env bash

# Terminate already running bar instances
polybar-msg cmd quit

# Wait until the processes have been shut down
while pgrep -u $USER -x polybar; do sleep 0.1; done

# Launch bars

if xrandr --listactivemonitors | grep -q "HDMI-1"; then
  polybar main &
fi

polybar vertical &
polybar external &

