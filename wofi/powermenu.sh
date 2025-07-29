#!/bin/bash

entries="󰐥  Power Off\n󰜉  Reboot\n󰤄  Suspend\n󰖔  Logout"

selected=$(echo -e "$entries" | wofi --dmenu --style ~/.config/wofi/style.css --prompt "Powermenu" --cache-file /dev/null)

case $selected in
  *Power*) poweroff ;;
  *Reboot*) reboot ;;
  *Suspend*) systemctl suspend ;;
  *Logout*) hyprctl dispatch exit ;;
esac
