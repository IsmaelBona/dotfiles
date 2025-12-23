#!/bin/bash

# Directorio de tus fondos de pantalla
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Listar archivos de imagen
wallpapers=$(ls "$WALLPAPER_DIR" | grep -E ".jpg$|.png$|.webp$")

# Menú de selección
chosen_wall=$(echo -e "$wallpapers" | rofi -dmenu -i -p "󰸉 Seleccionar Fondo:")

if [ -n "$chosen_wall" ]; then
    # Aplicar el fondo con awww
    # Nota: awww detecta automáticamente tus monitores
    awww img "$WALLPAPER_DIR/$chosen_wall"
    
    # Notificación
    notify-send "Sistema" "Fondo actualizado con awww: $chosen_wall"
fi
