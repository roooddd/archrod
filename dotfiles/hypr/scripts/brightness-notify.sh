#!/bin/bash

# Pega o nível atual de brilho em porcentagem
level=$(brightnessctl get)
max=$(brightnessctl max)
percent=$(( 100 * level / max ))

# Envia notificação pelo mako
notify-send "Brilho" "Nível atual: ${percent}%"
