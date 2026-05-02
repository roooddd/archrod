#!/bin/bash

ACTION_NAME="$1"

shift
ACTION_CMD="$@"

if [[ -z "$ACTION_CMD" || -z "$ACTION_NAME" ]]; then
    echo "ERRO: Uso: confirm.sh <comando> <nome da ação>"
    exit 1
fi

TIMEOUT_SECONDS=30

# Opções: Confirm <ação> e Cancel
OPTIONS=("Confirm $ACTION_NAME" "Cancel")

choice=$(printf "%s\n" "${OPTIONS[@]}" | timeout "${TIMEOUT_SECONDS}s" rofi \
    -dmenu -i \
    -config ~/.config/rofi/confirm.rasi \
    -selected-row 0 \
    -lines 2)

status=$?

if [[ $status -eq 124 ]]; then
    # Timeout: nenhuma escolha em 30s → executa automaticamente
    eval "$ACTION_CMD"
    exit 0
fi

case "$choice" in
    "Confirm $ACTION_NAME")
        eval "$ACTION_CMD"
        ;;
    "Cancel"|"")
        exit 0
        ;;
esac
