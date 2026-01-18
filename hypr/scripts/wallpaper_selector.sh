#!/bin/bash

# Directorio de tus fondos de pantalla
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# 1. Entrar al directorio y listar solo los nombres de archivos de imagen
# Usamos 'basename' para limpiar posibles rutas y 'sed' para quitar la extensión
cd "$WALLPAPER_DIR" || exit
wallpapers_display=$(ls *.jpg *.png *.webp *.jpeg 2>/dev/null | sed 's/\.[^.]*$//')

# 2. Menú de selección
chosen_name=$(echo -e "$wallpapers_display" | rofi -dmenu -i -p "󰸉 Seleccionar:")

if [ -n "$chosen_name" ]; then
    # 3. Recuperar el archivo real buscando el que empiece por el nombre elegido
    # El asterisco al final encontrará cualquier extensión (jpg, png, etc)
    chosen_wall=$(ls "$chosen_name".* | head -n 1)

    if [ -n "$chosen_wall" ]; then
        # Aplicar el fondo (usando la ruta completa)
        awww img "$WALLPAPER_DIR/$chosen_wall" --transition-type center --transition-duration 1 --transition-fps 60
        
        # Notificación
        notify-send "Sistema" "Fondo actualizado: $chosen_name"
    fi
fi
