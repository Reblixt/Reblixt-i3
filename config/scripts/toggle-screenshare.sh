#!/bin/bash

MONITOR_CONF_FILE="/home/carl/dotfiles/.config/hypr/conf/monitor.conf"
SOURCE_CURRENT="source = ~/.config/hypr/conf/monitors/current.conf"
SOURCE_SCREENSHARE="source = ~/.config/hypr/conf/monitors/screenshare.conf"

# Read the current source line from monitor.conf
current_source_line=$(grep '^source =' "$MONITOR_CONF_FILE")

if [ "$current_source_line" == "$SOURCE_CURRENT" ]; then
  # Switch to screenshare.conf
  echo "$SOURCE_SCREENSHARE" > "$MONITOR_CONF_FILE"
  echo "Switched to screenshare.conf"
elif [ "$current_source_line" == "$SOURCE_SCREENSHARE" ]; then
  # Switch to current.conf
  echo "$SOURCE_CURRENT" > "$MONITOR_CONF_FILE"
  echo "Switched to current.conf"
else
  # Default to current.conf if the line is something else or file is empty
  echo "$SOURCE_CURRENT" > "$MONITOR_CONF_FILE"
  echo "Set to default (current.conf) due to unknown state."
fi
