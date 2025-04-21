#!/bin/env bash

# Check if Spotify is already running
SPOTIFY_PID=$(pgrep -f "spotify")
if [ -z "$SPOTIFY_PID" ]; then
  # Start Spotify
  spotify
fi

# Wait 3 seconds
sleep 3

# Start Waybar
waybar --config ~/.config/waybar/desktop-bar/config --style .config/waybar/desktop-bar/style.css &
