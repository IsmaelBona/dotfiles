#!/bin/bash

# Ruta absoluta manual
WAYBAR_DIR="/home/wotang/.config/waybar"

# 1. Buscar carpetas que contengan config.jsonc usando globbing
TEMAS=""
for d in "$WAYBAR_DIR"/*/; do
    if [ -f "${d}config.jsonc" ]; then
        # Extraer solo el nombre de la carpeta (quitar la ruta y la barra final)
        folder=$(basename "$d")
        TEMAS+="$folder"$'\n'
    fi
done

# Limpiar posibles saltos de línea extra
TEMAS=$(echo "$TEMAS" | sed '/^$/d')

# --- DEPURACIÓN ---
echo "Contenido de la variable TEMAS:"
echo "[$TEMAS]"

if [ -z "$TEMAS" ]; then
    echo "ERROR: No se detectaron carpetas con config.jsonc en $WAYBAR_DIR"
    exit 1
fi

# 2. Rofi
SELECCION=$(echo -e "$TEMAS" | rofi -dmenu -p "Estilo Waybar" -i)

[ -z "$SELECCION" ] && exit 0

# 3. Aplicar
pkill waybar
sleep 0.2
waybar -c "$WAYBAR_DIR/$SELECCION/config.jsonc" -s "$WAYBAR_DIR/$SELECCION/style.css" &
