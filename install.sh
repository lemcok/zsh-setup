#!/bin/bash

set -e

REPO="https://github.com/lemcok/zsh-setup"
ZSH_CUSTOM="${HOME}/.oh-my-zsh/custom"

echo "[*] Instalando Zsh..."
sudo apt update && sudo apt install -y zsh git curl

echo "[*] Instalando Oh My Zsh..."
export RUNZSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "[*] Clonando plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM}/themes/powerlevel10k"

echo "[*] Clonando configuraciones personales..."
git clone "$REPO" "$HOME/.zshconfig"

echo "[*] Copiando .zshrc..."
cp "$HOME/.zshconfig/zsh/.zshrc" "$HOME/.zshrc"

echo "[*] Listo. Cambiando a Zsh por defecto (requiere contraseña)..."
chsh -s $(which zsh)

echo "✅ Instalación completa. Reinicia la terminal o ejecuta: zsh"

