#!/bin/bash

# Colores para la salida
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}Iniciando instalación de Dotfiles...${NC}"

# 1. Actualizar sistema
sudo pacman -Syu --noconfirm

# 2. Instalar yay (si no está instalado)
if ! command -v yay &>/dev/null; then
  echo "Instalando yay (AUR helper)..."
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd ..
  rm -rf yay
fi

# 3. Instalar paquetes desde el .txt
echo -e "${GREEN}Instalando paquetes desde pkglist.txt...${NC}"
# Filtramos comentarios y instalamos
grep -v '^#' pkglist | xargs yay -S --needed --noconfirm

# 4. Crear enlaces simbólicos (Symlinks)
echo -e "${GREEN}Creando enlaces simbólicos...${NC}"

# Usamos el comando ln -sfnv que buscabas
# Ajusta 'dotfiles_folder' al nombre de tu carpeta en el repo
DOTFILES_DIR=$(pwd)

# Ejemplo para Neovim
ln -sfnv "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# Ejemplo para Kitty
ln -sfnv "$DOTFILES_DIR/kitty" "$HOME/.config/kitty"

# Ejemplo para Zsh (fuera de .config)
ln -sfnv "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

echo -e "${GREEN}¡Todo listo! Reinicia la terminal.${NC}"
