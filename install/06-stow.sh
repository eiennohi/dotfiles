#!/usr/bin/env bash
set -e

echo "Applying dotfiles with stow..."

cd "$HOME/dotfiles"

stow git
stow hypr
stow nvim
stow kitty
stow starship
stow zsh
stow DankMaterialShell
