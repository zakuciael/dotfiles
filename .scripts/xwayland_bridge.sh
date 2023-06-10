#!/bin/env sh

source ~/.scripts/tools/logger.sh

while [ : ]; do
  status "Running X Wayland Bridge..."
  xwaylandvideobridge

  if [ $? -ne 0 ]; then
    fail "Running X Wayland Bridge..."
  else
    success "Running X Wayland Bridge..."
  fi

  sleep 1
done
