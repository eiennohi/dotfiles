#!/usr/bin/env bash
set -e

echo "Configuring NVIDIA..."

sudo tee /etc/modprobe.d/blacklist-nouveau.conf > /dev/null <<EOF
blacklist nouveau
options nouveau modeset=0
EOF

sudo tee /etc/modprobe.d/nvidia.conf > /dev/null <<EOF
options nvidia_drm modeset=1
EOF

if ! grep -q "nvidia_drm.modeset=1" /etc/default/grub; then
  sudo sed -i \
  's/^GRUB_CMDLINE_LINUX_DEFAULT="/&nvidia_drm.modeset=1 /' \
  /etc/default/grub
fi

sudo mkinitcpio -P
sudo grub-mkconfig -o /boot/grub/grub.cfg
