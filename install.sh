#!/bin/bash

set -e

REPO="https://github.com/lemcok/zsh-setup"
ZSH_CUSTOM="${HOME}/.oh-my-zsh/custom"
FONTS_DIR="$HOME/.local/share/fonts"

echo "[*] Verificando que se ejecuta en Arch Linux..."
if ! grep -qi arch /etc/os-release; then
  echo "❌ Este script está diseñado para Arch Linux."
  exit 1
fi

echo "[*] Instalando Zsh y dependencias..."
sudo pacman -Sy --noconfirm zsh git curl

echo "[*] Instalando Oh My Zsh..."
export RUNZSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "[*] Instalando plugins de Zsh..."
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM}/themes/powerlevel10k"

echo "[*] Clonando configuraciones personales..."
git clone "$REPO" "$HOME/.zshconfig"
cp "$HOME/.zshconfig/zsh/.zshrc" "$HOME/.zshrc"


echo "[*] Instalando fuente Nerd desde archivos locales..."

mkdir -p "$FONTS_DIR"
cp "$HOME/.zshconfig/fonts/"*.ttf "$FONTS_DIR"

echo "[*] Actualizando caché de fuentes..."
fc-cache -f "$FONTS_DIR"

echo "[*] Cambiando shell por defecto a Zsh..."
chsh -s "$(which zsh)"

echo "✅ Instalación completa."
echo "🎨 Asegúrate de que tu terminal esté usando 'FiraCode Nerd Font'."
echo "🔁 Reinicia tu terminal, y asegúrate de configurar tu terminal para usar 'FiraCode Nerd Font'."
