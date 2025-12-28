#!/usr/bin/env bash

width=40

# status e metadados
status=$(playerctl status 2>/dev/null)
artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)
player=$(playerctl -l | head -n 1)   # pega o primeiro player ativo

artist=$(echo "$artist" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g')
title=$(echo "$title" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g')

# ícone de status
case "$status" in
    Playing) status_icon="▶" ;;
    Paused)  status_icon="⏸" ;;
    Stopped|"") status_icon="⏹" ;;
    *) status_icon="⏹" ;;
esac

# ícone do player
case "$player" in
    *spotify*) app_icon="" ;;   # ícone do Spotify (Nerd Font / Font Awesome)
    *) app_icon="󰝚" ;;          # nota musical como default
esac

# texto
if [ -n "$artist" ] && [ -n "$title" ]; then
    text="$title - $artist"
else
    text="not playing anything..."
fi

len=${#text}

if [ $len -le $width ]; then
    echo "$status_icon $app_icon $text"
    exit 0
fi

# --- rolagem bidirecional ---
t=$(date +%s)
range=$((len - width))
cycle=$((range * 2))
pos=$((t % cycle))

if [ $pos -lt $range ]; then
    offset=$pos
else
    offset=$((range - (pos - range)))
fi

scroll="${text:$offset:$width}"
printf "%s %s %-${width}s\n" "$status_icon" "$app_icon" "$scroll"
