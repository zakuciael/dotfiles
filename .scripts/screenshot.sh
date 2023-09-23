#!/bin/env sh

SAVE_TO_FILE=false

get_focused_monitor() {
  if [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
    xrandr | rg "$(bspc query -M --names -m .focused) .+ ([0-9]+)x([0-9]+)\+([0-9]+)\+([0-9]+)" -or '${1}x${2}+${3}+${4}'
  else
    hyprctl monitors -j | jq -r '.[] | select(.focused) | .name'
  fi
}

get_active_window() {
  if [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
    bspc query -T -n $(bspc query -N -n .focused) | jq -r '.client | { border: .borderWidth, rect: .[(.state + "Rectangle")]} | "\(.rect.width+(.border*2))x\(.rect.height+(.border*2))+\(.rect.x)+\(.rect.y)"'
  else
    hyprctl activewindow -j | jq -r '"\(.at[0]-5),\(.at[1]-5) \(.size[0]+10)x\(.size[1]+10)"'
  fi

}

get_file_name() {
  # echo "/tmp/test.png"
  echo "$(xdg-user-dir PICTURES)/Screenshots/$(date +'%Y-%m-%d_%H-%M.png')"
}

print_help() {
  echo "Usage: screenshot.sh [..OPTIONS] CMD"
  echo ""
  echo "OPTIONS:"
  echo " -h, --help         | Print help text and exit"
  echo " -f, --file         | Output screenshot to a file in \$XDG_PICTURES_DIR/Screenshots"
  echo "COMMANDS:"
  echo " window             | Capture active window"
  echo " screen             | Capture entire screen"
  echo " region             | Capture selected region"
}

OPTS=$(getopt -n screenshot -o fh --long file,help -- "$@")
if [[ $? -ne 0 ]]; then
  exit 1;
fi

eval set -- "$OPTS"

while [ : ]; do
  case "$1" in
    -f | --file)
      SAVE_TO_FILE=true
      shift
      ;;
    -h | --help)
      print_help
      exit 0
      ;;
    --)
      shift
      break
      ;;
    *)
      print_help
      exit 1
      ;;
    ?)
      print_help
      exit 1
      ;;
  esac
done

case "$1" in
  window)
    if [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
      if [[ $SAVE_TO_FILE == true ]]; then
        maim -g "$(get_active_window)" "$(get_file_name)"
      else
        maim -g "$(get_active_window)" | xclip -selection clipboard -t image/png
      fi
    else
      if [[ $SAVE_TO_FILE == true ]]; then
        grim -g "$(get_active_window)" "$(get_file_name)"
      else
        grim -g "$(get_active_window)" - | wl-copy
      fi
    fi
    ;;
  screen)
    if [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
      if [[ $SAVE_TO_FILE == true ]]; then
        maim -g "$(get_focused_monitor)" "$(get_file_name)"
      else
        maim -g "$(get_focused_monitor)" | xclip -selection clipboard -t image/png
      fi
    else
      if [[ $SAVE_TO_FILE == true ]]; then
        grim -o "$(get_focused_monitor)" "$(get_file_name)"
      else
        grim -o "$(get_focused_monitor)" - | wl-copy
      fi
    fi
    ;;
  region)
    if [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
      if [[ $SAVE_TO_FILE == true ]]; then
        maim -s "$(get_file_name)"
      else
        maim -s | xclip -selection clipboard -t image/png
      fi
    else
      if [[ $SAVE_TO_FILE == true ]]; then
        grim -g "$(slurp)" "$(get_file_name)"
      else
        grim -g "$(slurp)" - | wl-copy
      fi
    fi
    ;;
  *)
    if [ -z "$1" ]; then
      echo "Error: No command specified"
    else
      echo "Error: Invalid command: $1"
    fi

    print_help
    exit 1
    ;;
esac
