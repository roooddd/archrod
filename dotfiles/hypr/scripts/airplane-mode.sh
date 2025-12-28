#!/bin/bash

# Verifica se já está bloqueado
if rfkill list all | grep -q "Soft blocked: yes"; then
    # Se já está bloqueado, desbloqueia (desliga modo avião)
    rfkill unblock all
    notify-send "Modo avião desativado" "Conexões de rede e Bluetooth reativadas."
else
    # Se não está bloqueado, bloqueia (liga modo avião)
    rfkill block all
    notify-send "Modo avião ativado" "Todas as conexões foram desativadas."
fi
