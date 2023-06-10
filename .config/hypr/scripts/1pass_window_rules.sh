#!/bin/env sh

source ~/.config/hypr/rules.tools

handle() {
  eval $@

  if [[ $EVENT == "openwindow" ]]; then
    if [[ ${DATA[class]} == "1Password" ]] && [[ ${DATA[title]} == "1Password" ]]; then
      local SIZE=$(get_window ${DATA[address]} | jq -r '. | "\(.size[0]) \(.size[1])"')
      # hyprctl dispatch resizeactive exact $SIZE

      hyprctl dispatch focuswindow ^\(${DATA[class]}\)$
      hyprctl dispatch centerwindow
      hyprctl dispatch focuswindow ^\(${DATA[class]}\)$
    fi
  fi
}

listen handle
