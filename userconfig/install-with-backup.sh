#!/bin/sh

set -e
sudo mv /etc/nixos/configuration.nix ./config-backup/configuration-backup.nix
echo "Backup made. Copying"
sudo cp configuration.nix /etc/nixos/
echo "Configuration copied. Done."
echo "run 'sudo nixos-rebuild switch' to apply."

