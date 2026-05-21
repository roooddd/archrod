#!/bin/bash

#  PATHS 
WALL_DIR="$HOME/Pictures/wallpapers"
ROFI_CONFIG="$HOME/.config/rofi/wallpapers-rofi.rasi"
LAST_WALL="$HOME/.cache/last_wallpaper"

#  MONITOR 
focused_monitor=$(hyprctl monitors | awk '/^Monitor/{name=$2} /focused: yes/{print name}')

#  AWWW TRANSITION 
FPS=60
TYPE="grow"
DURATION=0.6
BEZIER="0.77,0,0.175,1"
AWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"

#  MATUGEN 
MATUGEN_MODE="dark"
MATUGEN_COLOR_INDEX=0

#  INIT ─
pidof swaybg >/dev/null && pkill swaybg
pidof rofi   >/dev/null && pkill rofi && sleep 1
awww query   >/dev/null 2>&1 || awww-daemon --format xrgb &

#  COLETA E ORDENA WALLPAPERS ─
mapfile -d '' ALL_PICS < <(find "$WALL_DIR" -type f \
  \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) -print0)

IFS=$'\n' sorted_pics=($(sort <<<"${ALL_PICS[*]}"))
unset IFS

#  WALLPAPER ATUAL ─
current_path=$(readlink -f "$LAST_WALL" 2>/dev/null)
current_stem=$(basename "$current_path" 2>/dev/null)
current_stem="${current_stem%.*}"

#  REORDENA LISTA PARA COMEÇAR PELO ATUAL ─
start_index=0
for i in "${!sorted_pics[@]}"; do
  stem=$(basename "${sorted_pics[$i]}")
  stem="${stem%.*}"
  if [[ "$stem" == "$current_stem" ]]; then
    start_index=$i
    break
  fi
done

total=${#sorted_pics[@]}
reordered=()
for offset in $(seq 0 $((total - 1))); do
  idx=$(( (start_index + offset) % total ))
  reordered+=("${sorted_pics[$idx]}")
done

#  MENU (rofi) ─
build_menu() {
  for pic_path in "${reordered[@]}"; do
    pic_name=$(basename "$pic_path")
    stem="${pic_name%.*}"
    if [[ "$pic_name" =~ \.gif$ ]]; then
      printf "%s\n" "$stem"
    else
      printf "%s\x00icon\x1f%s\n" "$stem" "$pic_path"
    fi
  done
}

chosen=$(build_menu | rofi -i -cycle -dmenu \
  -config "$ROFI_CONFIG" \
  -select "$current_stem")

[[ -z "$chosen" ]] && exit 0

#  ACHA PATH COMPLETO 
chosen_path=""
for pic in "${reordered[@]}"; do
  stem=$(basename "$pic")
  stem="${stem%.*}"
  if [[ "$stem" == "$chosen" ]]; then
    chosen_path="$pic"
    break
  fi
done

if [[ -z "$chosen_path" ]]; then
  echo "Imagem não encontrada: $chosen"
  exit 1
fi

#  APLICA 
awww img "$chosen_path" $AWWW_PARAMS --outputs "$focused_monitor"
matugen image "$chosen_path" -m "$MATUGEN_MODE" --source-color-index "$MATUGEN_COLOR_INDEX"
ln -sf "$chosen_path" "$LAST_WALL"