#!/usr/bin/env bash
set -e

if command -v yay >/dev/null; then
  echo "yay already installed."
  exit 0
fi

echo "Installing yay..."

YAY_DIR =$(mktemp -d)

git clone https://aur.archlinux.org/yay.git YAY_DIR
cd YAY_DIR
makepkg -si --no-confirm

cd ~
rm -rf "YAY_DIR"
