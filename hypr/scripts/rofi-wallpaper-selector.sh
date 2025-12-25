#!/bin/bash

# WALLPAPERS PATH
wallDIR="$HOME/Pictures/wallpapers"
SCRIPTSDIR="$HOME/.config/hypr/scripts"

# variables
focused_monitor=$(hyprctl monitors | awk '/^Monitor/{name=$2} /focused: yes/{print name}')

# swww transition config
FPS=60
TYPE="grow"
DURATION=0.6
BEZIER="0.43,1.19,1,0.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"

# Kill swaybg if running
pidof swaybg >/dev/null && pkill swaybg

# Retrieve image files
mapfile -d '' PICS < <(find "${wallDIR}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) -print0)

# Nome atual do wallpaper (sem extensão, para bater com o texto exibido)
current_wallpaper="$(basename "$(readlink -f ~/.cache/last_wallpaper)")"
current_name="${current_wallpaper%.*}"

# Rofi command
rofi_command="rofi -i -cycle -show -dmenu -config ~/.config/rofi/wallpapers-rofi.rasi -select \"$current_name\""

# Sorting Wallpapers
menu() {
  IFS=$'\n' sorted_options=($(sort <<<"${PICS[*]}"))

  # encontra índice do atual
  start_index=0
  for i in "${!sorted_options[@]}"; do
    filename=$(basename "${sorted_options[$i]}")
    name="${filename%.*}"
    if [[ "$name" == "$current_name" ]]; then
      start_index=$i
      break
    fi
  done

  # reordena lista para começar pelo atual
  total=${#sorted_options[@]}
  reordered=()
  for offset in $(seq 0 $((total-1))); do
    idx=$(( (start_index + offset) % total ))
    reordered+=("${sorted_options[$idx]}")
  done

  # imprime lista reordenada
  for pic_path in "${reordered[@]}"; do
    pic_name=$(basename "$pic_path")
    if [[ ! "$pic_name" =~ \.gif$ ]]; then
      printf "%s\x00icon\x1f%s\n" "${pic_name%.*}" "$pic_path"
    else
      printf "%s\n" "$pic_name"
    fi
  done
}

# initiate swww if not running
swww query || swww-daemon --format xrgb

main() {
  choice=$(menu | eval $rofi_command)
  choice=$(echo "$choice" | xargs)

  [[ -z "$choice" ]] && exit 0

  pic_index=-1
  for i in "${!PICS[@]}"; do
    filename=$(basename "${PICS[$i]}")
    if [[ "$filename" == "$choice"* ]]; then
      pic_index=$i
      break
    fi
  done

  if [[ $pic_index -ne -1 ]]; then
    matugen image "${PICS[$pic_index]}" -m "dark"
    ln -sf "${PICS[$pic_index]}" ~/.cache/last_wallpaper
  else
    echo "Image not found."
    exit 1
  fi
}

pidof rofi >/dev/null && pkill rofi && sleep 1

main
