#!/bin/bash

while true; do
    capacity=$(upower -i $(upower -e | grep BAT) | grep -E "percentage" | awk '{print $2}' | tr -d '%')
    status=$(upower -i $(upower -e | grep BAT) | grep -E "state" | awk '{print $2}')

    if [ "$capacity" -le 20 ] && [ "$status" = "discharging" ]; then
        notify-send -u critical "Bateria baixa" "Restam apenas $capacity% de carga!"
    fi

    sleep 60
done
