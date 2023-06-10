#!/bin/env sh

# Colors
BLACK='\e[30m'
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
MAGENTA='\e[35m'
CYAN='\e[36m'
GRAY='\e[90m'
WHITE='\e[97m'

LIGHT_GRAY='\e[37m'
LIGHT_RED='\e[91m'
LIGHT_GREEN='\e[92m'
LIGHT_YELLOW='\e[93m'
LIGHT_BLUE='\e[94m'
LIGHT_MAGENTA='\e[95m'
LIGHT_CYAN='\e[96m'

RESET='\e[0m'
BOLD='\e[1m'
FAINT='\e[2m'
ITALIC='\e[3m'
UNDERLINE='\e[4m'

DEBUG=false
REPLACE_NEXT_LINE=false

# Log types
declare -g -A MSGTYPE_PREFIXES=(
  [status]='x'
  [success]='+'
  [fail]='-'
  [debug]='DEBUG'
  [info]='*'
  [warn]='!'
  [error]='ERROR'
  [critical]='CRITICAL'
)

declare -g -A MSGTYPE_COLORS=(
  [status]="${BOLD}${MAGENTA}"
  [success]="${BOLD}${GREEN}"
  [fail]="${BOLD}${RED}"
  [debug]="${BOLD}${YELLOW}"
  [info]="${BOLD}${BLUE}"
  [warn]="${BOLD}${YELLOW}"
  [error]="${BOLD}${RED}"
  [critical]="${BOLD}${RED}"
)


if [[ $* == *"--debug"* ]]; then
  DEBUG=true
fi

log() {
  local MSGTYPE=$1
  local MSG="$2"
  local REPLACE_MODE=${3:-false}

  local FORMATTED_MSG="${BOLD}[${RESET}${MSGTYPE_COLORS[${MSGTYPE}]}${MSGTYPE_PREFIXES[${MSGTYPE}]}${RESET}${BOLD}]${RESET} ${MSG}${RESET}"

  if [[ ${DEBUG} == false ]] && [[ ${MSGTYPE} == "debug" ]]; then
    return
  fi

  if [ ${REPLACE_NEXT_LINE} == true ]; then
    echo -e "\r\033[K${FORMATTED_MSG}"
    REPLACE_NEXT_LINE=false
    return
  fi

  if [ ${REPLACE_MODE} != true ]; then
    echo -e "${FORMATTED_MSG}"
  else
    echo -en "${FORMATTED_MSG}"
    REPLACE_NEXT_LINE=true
  fi
}

status() {
  local MSG="$1"
  local ARGS=${@:2}
  log "status" "${MSG}" $ARGS
}

success() {
  local MSG="$1"
  local ARGS=${@:2}

  log "success" "${MSG}" $ARGS
}

fail() {
  local MSG="$1"
  local ARGS=${@:2}
  log "fail" "${MSG}" $ARGS
}

debug() {
  local MSG="$1"
  local ARGS=${@:2}
  log "debug" "${MSG}" $ARGS
}

info() {
  local MSG="$1"
  local ARGS=${@:2}
  log "info" "${MSG}" $ARGS
}

warn() {
  local MSG="$1"
  local ARGS=${@:2}
  log "warn" "${MSG}" $ARGS
}

error() {
  local MSG="$1"
  local ARGS=${@:2}
  log "error" "${MSG}" $ARGS
}

critical() {
  local MSG="$1"
  local ARGS=${@:2}
  log "critical" "${MSG}" $ARGS
}
