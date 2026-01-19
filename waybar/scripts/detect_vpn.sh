#!/bin/bash

# 1. Buscamos la línea activa
VPN_LINE=$(nmcli -t -f name,type,state connection show --active | grep "ProtonVPN" | grep "activated" | head -n 1)

if [ ! -z "$VPN_LINE" ]; then
    FULL_NAME=$(echo "$VPN_LINE" | cut -d: -f1)

    # 2. Extraer el código del país usando -P para evitar el warning
    COUNTRY=$(echo "$FULL_NAME" | grep -oP '[A-Z]{2}(?=#)')

    # Si falla por algo, buscar cualquier par de mayúsculas (fallback)
    [ -z "$COUNTRY" ] && COUNTRY=$(echo "$FULL_NAME" | grep -oE '[A-Z]{2}' | tail -n 1)

    ICON="VPN:"
    echo "{\"text\": \"$ICON $COUNTRY\", \"tooltip\": \"Conexión: $FULL_NAME\", \"class\": \"connected\"}"
else
    echo "{\"text\": \"\", \"class\": \"disconnected\"}"
fi
