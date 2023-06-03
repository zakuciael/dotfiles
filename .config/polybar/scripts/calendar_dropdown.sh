#!/bin/env bash

TDROP_NAME="calendar"
CLASS_NAME="calendar_dropdown"
PROFILE_NAME="calendar"

tdrop -n $TDROP_NAME --class $CLASS_NAME \
  --wm bspwm -ma \
  -w 50% -h 50% -y 25 -x 25% \
  thunderbird-beta -new-instance -P "$PROFILE_NAME" -calendar --class $CLASS_NAME
