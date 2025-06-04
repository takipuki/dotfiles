#! /usr/bin/env bash

w="$(hyprctl activewindow | grep workspace:)"
if [[ "$w" = *special* ]]; then
	hyprctl dispatch movetoworkspacesilent +0
else
	hyprctl dispatch movetoworkspacesilent special
fi
