#!/bin/env sh

SAVE_TO_FILE=false

get_focused_monitor() {
  hyprctl monitors -j | jq -r '.[] | select(.focused) | .name'
}

get_active_window() {
  hyprctl activewindow -j | jq -r '"\(.at[0]-5),\(.at[1]-5) \(.size[0]+10)x\(.size[1]+10)"'
}

get_file_name() {
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
    if [[ $SAVE_TO_FILE == true ]]; then
      grim -g "$(get_active_window)" "$(get_file_name)"
    else
      grim -g "$(get_active_window)" - | wl-copy
    fi
    ;;
  screen)
    if [[ $SAVE_TO_FILE == true ]]; then
      grim -o "$(get_focused_monitor)" "$(get_file_name)"
    else
      grim -o "$(get_focused_monitor)" - | wl-copy
    fi
    ;;
  region)
    if [[ $SAVE_TO_FILE == true ]]; then
      grim -g "$(slurp)" "$(get_file_name)"
    else
      grim -g "$(slurp)" - | wl-copy
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
