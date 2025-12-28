#!/usr/bin/env bash
set -euo pipefail

FOCUSED_MONITOR=$(hyprctl monitors | awk '/Monitor/{mon=$2} /focused: yes/{print mon}')
FOCUSED_MONITOR="${FOCUSED_MONITOR:-0}"

case "${1:-}" in
  -f|--fullscreen)
    grim -o "$FOCUSED_MONITOR" - | swappy -f - >/dev/null 2>&1 &
    ;;

  -s|--selection)
    geom=$(slurp) || exit 1
    [ -n "$geom" ] || exit 1
    grim -g "$geom" - | swappy -f - >/dev/null 2>&1 &
    ;;

  *)
    echo "Uso: $0 -f|--fullscreen  -s|--selection"
    exit 1
    ;;
esac

exit 0
