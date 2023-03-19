#/bin/bash

SPOTIFY=false
DUNST_TAG="player_volume"

function get_system_vol() {
  local SYSTEM_SINK_ID=$(pactl list short | grep RUNNING | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,')
  local SYSTEM_VOLUME=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $62 + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')

  echo $SYSTEM_VOLUME
}

function get_player_vol() {
  local VOLUME_PROC=$(LC_NUMERIC=C printf "%.0f" $(echo "$(playerctl -p spotify volume) * 100" | bc))

  echo $VOLUME_PROC
}

function fallback_cmd() {
  local CMD=$1
  local FALLBACK=$2

  if [ $SPOTIFY = true ]; then
    $CMD
  else
    $FALLBACK
  fi
}

function toggle_play() {
  fallback_cmd "playerctl -p spotify play-pause" "playerctl play-pause"
}

function play() {
  fallback_cmd "playerctl -p spotify play" "playerctl play"
}

function pause() {
  fallback_cmd "playerctl -p spotify pause" "playerctl pause"
}

function stop() {
  fallback_cmd "playerctl -p spotify stop" "playerctl stop"
}

function next() {
  fallback_cmd "playerctl -p spotify next" "playerctl next"
}

function prev() {
  fallback_cmd "playerctl -p spotify previous" "playerctl previous"
}

function to_floating() {
  if [ $1 -ge 100 ]; then
      local VOLUME=1
    elif [ $1 -le 0 ]; then
      local VOLUME=0
    else
      local VOLUME=$(printf "0.%02.0f" $1)
  fi

  echo $VOLUME
}

function volume() {
  local INPUT=$1

  if [ $SPOTIFY = false ]; then
    pactl set-sink-volume @DEFAULT_SINK@ $1

    local SYSTEM_SINK_ID=$(pactl list short | grep RUNNING | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,')
    local SYSTEM_VOLUME=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $62 + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')

    dunstify -a "player_volume" -u low -i audio-volume-high -h string:x-dunst-stack-tag:$DUNST_TAG -h int:value:"$SYSTEM_VOLUME" "Volume: ${SYSTEM_VOLUME}%"
    return
  fi

  if [ -z $INPUT ]; then
    echo "Error: Missing argument <value>"
    print_help
    exit 1
  fi

  local REGEX="^([-+])?([[:digit:]]+)%?$"

  if [[ $INPUT =~ $REGEX ]]; then

    if [ ! -z ${BASH_REMATCH[1]} ]; then
      if [[ $(echo "$(playerctl -p spotify volume) <= 0" | bc) -eq 1 ]] && [[ ! -f /tmp/spotify_vol ]]; then
        echo "Warning: Spotify is already muted, but the temp file doesn't exist. Setting default value.."
        local VOLUME=0.30
      elif [[ -f /tmp/spotify_vol ]]; then
        local VOLUME=$(/usr/bin/cat /tmp/spotify_vol)
        /usr/bin/rm -rf /tmp/spotify_vol
      fi

      playerctl -p spotify volume $VOLUME
    fi

    local VOLUME="$(to_floating ${BASH_REMATCH[2]})${BASH_REMATCH[1]}"
  else
    echo "Error: Invalid argument <value>"
    print_help
    exit 1
  fi

  playerctl -p spotify volume $VOLUME
  local VOLUME_PROC=$(LC_NUMERIC=C printf "%.0f" $(echo "$(playerctl -p spotify volume) * 100" | bc))
  dunstify -a "player_volume" -u low -i audio-volume-high -h string:x-dunst-stack-tag:$DUNST_TAG -h int:value:"$VOLUME_PROC" "Spotify Volume: ${VOLUME_PROC}%"
}

function loop() {
  local INPUT=$1
  local REGEX="^(None|Track|Playlist)$"

  if [[ $INPUT =~ $REGEX ]]; then
    fallback_cmd "playerctl -p spotify loop $INPUT" "playerctl loop $INPUT"
  else
    echo "Error: Invalid argument <loop_type>"
    print_help
    exit 1
  fi
}

function toggle_mute() {
  if [ $SPOTIFY = false ]; then
    pactl set-sink-mute @DEFAULT_SINK@ toggle

    local MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | awk -F" " '{print $2}')

    if [ $MUTED = "yes" ]; then
      local MSG="Volume muted"
    else
      local MSG="Volume unmuted"
    fi

    dunstify -a "player_volume" -u low -i audio-volume-muted -h string:x-dunst-stack-tag:$DUNST_TAG "$MSG"
    return
  fi

  if [[ $(echo "$(playerctl -p spotify volume) <= 0" | bc) -eq 1 ]] && [[ ! -f /tmp/spotify_vol ]]; then
    echo "Warning: Spotify is already muted, but the temp file doesn't exist. Setting default value.."
    local VOLUME=0.30
  elif [[ -f /tmp/spotify_vol ]]; then
    local VOLUME=$(/usr/bin/cat /tmp/spotify_vol)
    /usr/bin/rm -rf /tmp/spotify_vol
  else
    local VOLUME=0
    echo -n $(playerctl -p spotify volume) > /tmp/spotify_vol
  fi

  playerctl -p spotify volume $VOLUME
}

function toggle_shuffle() {
  fallback_cmd "playerctl -p spotify shuffle toggle" "playerctl shuffle toggle"
}

function print_help() {
  echo "Usage: player.sh [..OPTIONS] CMD [..ARGS]"
  echo ""
  echo "OPTIONS:"
  echo " -s, --spotify                  | Use spotify instead of currently playing player"
  echo " -h, --help                     | Print help text and exit"
  echo ""
  echo "COMMANDS:"
  echo " play                           | Command the player to play"
  echo " pause                          | Command the player to pause"
  echo " toggle                         | Command the player to toggle between play and pause"
  echo " stop                           | Command the player to stop"
  echo " next                           | Command the player to skip to the next track"
  echo " prev                           | Command the player to skip to the previous track"
  echo " shuffle                        | Command the player to toggle between on and off shuffle staus"
  echo " mute                           | Command the player to toggle between muted and unmuted volume"
  echo " volume, vol <[+|-]value[%]>    | Command the player to set the volume to the specified value. With the optional [+|-] appended, increase or decrease the player's volume by the value."
  echo " loop <loop_type>               | Command the player to set the loop status to None (disable looping), Track (loop the current track) or Playlist (loop the current playlist)."

}

OPTS=$(getopt -n player -o sh --long spotify,help -- "$@")
if [[ $? -ne 0 ]]; then
  exit 1;
fi

eval set -- "$OPTS"

while [ : ]; do
  case "$1" in
    -s | --spotify)
      SPOTIFY=true
      shift
      ;;
    -h | --help)
      print_help
      exit 0
      ;;
    --) 
      shift;
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
  play)
    play
    ;;
  pause)
    pause
    ;;
  toggle)
    toggle_play
    ;;
  stop)
    stop
    ;;
  next)
    next
    ;;
  prev)
    prev
    ;;
  shuffle)
    toggle_shuffle
    ;;
  loop)
    loop $2
    ;;
  volume | vol)
    volume $2
    ;;
  mute)
    toggle_mute
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
