#!/usr/bin/env sh

pkill polybar && sleep 1
# Starta polybar för primära skärmen
MONITOR=DP-0 polybar -c ~/.config/polybar/config.ini primary &
sleep 1
# Starta polybar för sekundära skärmen
MONITOR=DP-2 polybar -c ~/.config/polybar/config.ini secondary &
