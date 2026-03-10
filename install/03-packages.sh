#!/usr/bin/env bash
set -e

cho "Installing pacman packages..."

sudo pacman -S --needed --noconfirm - < packages.txt

echo "Installing AUR packages..."

yay -S --needed --noconfirm - < aur-packages.txt
