#!/bin/bash

# Detectar el gestor de paquetes
if command -v pacman > /dev/null; then
    PACMAN="sudo pacman -Syu"
    CHECK="checkupdates"
elif command -v apt > /dev/null; then
    PACMAN="sudo apt update && sudo apt upgrade"
    CHECK="apt list --upgradable"
fi

# Obtener lista de actualizaciones
updates=$($CHECK | wc -l)

if [ "$updates" -gt 0 ]; then
    msg="󰚰  Updates: $updates"
else
    msg="󰄬  System Updated"
fi

# Menú de Rofi con botones
options="󰚰  Update Now\n󰑐  Refresh\n󰅙  Exit"

chosen=$(echo -e "$options" | rofi -dmenu -p "$msg" -i -show-icons -theme ~/.config/rofi/basic_menu.rasi)

case "$chosen" in
    "󰚰  Update Now")
        # Abre una terminal para ver el proceso de actualización
        ghostty -e bash -c "$PACMAN; echo 'Done! Press any key...'; read -n 1"
        ;;
    "󰑐  Refresh")
        $0 # Reinicia el script
        ;;
    "󰅙  Exit")
        exit 0
        ;;
esac