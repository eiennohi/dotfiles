#!/usr/bin/env bash
set -e

echo "Installing base dependencies..."
sudo pacman -Sy --needed git base-devel stow

DOTFILES_DIR="$HOME/.dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Cloning dotfiles..."
  git clone https://github.com/eiennohi/dotfiles.git "$DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"

echo "Running install scripts..."

for script in install/*.sh; do
  bash "$script"
done

echo "Bootstrap complete."
