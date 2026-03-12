#!/usr/bin/env bash
set -e

echo "Applying dotfiles with stow..."

cd "$HOME/dotfiles"

stow environment.d
stow scripts
stow zsh
stow git
stow hypr
stow nvim
stow kitty
stow starship
stow DankMaterialShell
stow satty
