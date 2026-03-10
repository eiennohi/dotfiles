#!/usr/bin/env bash
set -e

echo "Applying system tweaks..."

echo "Applying locales..."
ln -sf /usr/share/zoneinfo/America/Argentina/Buenos_Aires /etc/localtime
hwclock -systohc

echo "en_US.UTF8 UTF8" > /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo "KEYMAP=la-latin1" > /etc/vconsole.conf
loadkeys la-latin1


sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service
sudo systemctl enable NetworkManager


sudo systemctl enable systemd-networkd.service
sudo systemctl start systemd-networkd.service


sudo systemctl enable systemd-timesyncd.service
sudo systemctl start systemd-timesyncd.service

if [ ! -f "$HOME/.gitconfig.local" ]; then
  echo "Creating ~/.gitconfig.local (edit this manually)"
  cat <<EOF > "$HOME/.gitconfig.local"
[user]
    name = Your Name
    email = your@email.com
EOF
fi
