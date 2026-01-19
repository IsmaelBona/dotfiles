#!/bin/bash

# Usamos la ruta absoluta expandiendo $HOME
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# 1. Generar la lista usando el protocolo oficial de Rofi
wallpapers_input=""
for file in "$WALLPAPER_DIR"/*; do
    # Verificar que sea un archivo y que sea una imagen
    if [[ -f "$file" && "$file" =~ \.(jpg|jpeg|png|webp)$ ]]; then
        name=$(basename "$file" | sed 's/\.[^.]*$//')
        # Según la doc: EntryName\0icon\x1fthumbnail://path/to/file
        wallpapers_input+="${name}\0icon\x1fthumbnail://${file}\n"
    fi
done

# 2. Lanzar Rofi con el tema personalizado y habilitando iconos
chosen_name=$(echo -e "$wallpapers_input" | rofi -dmenu -i -p "󰸉 Fondo" -show-icons -theme ~/.config/rofi/wallpapers.rasi)

if [ -n "$chosen_name" ]; then
    # 3. Buscar el archivo original para aplicarlo
    chosen_wall=$(ls "$WALLPAPER_DIR/$chosen_name".* | head -n 1)

    if [ -n "$chosen_wall" ]; then
        awww img "$chosen_wall" --transition-type center --transition-duration 1
    fi
fi
