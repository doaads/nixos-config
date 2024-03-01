#!/bin/sh
# This script is used to install the nixos configuration on a new machine
# It will link the configuration files to the current directory and install home-manager
# sudo is required to link the configuration files

set -e

echo "linking hardware-configuration.nix to current dir"
ln -s /etc/nixos/hardware-configuration.nix ./hardware-configuration.nix

# the setup will use an existing configuration.nix file
# if you prefer to use the preconfigured one - it is available in useconfig directory
# if you don't want the config linked - run with -n or --no-link flag

if [ "$1" = "-n" ] || [ "$1" = "--no-link" ]; then
	echo "skipping linking of configuration.nix"
else
	echo "linking configuration.nix to current dir"
	ln -s /etc/nixos/configuration.nix ./configuration.nix
fi

if command -v "home-manager" > /dev/null; then
	echo "home-manager is already installed"
else
	echo "home-manager is not installed"
	echo "installing..."
	nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
	nix-channel --update
	nix-shell '<home-manager>' -A install
fi

echo "-----------------------------------------------------------------"
echo "directories linked successfully"
echo "home-manager installation complete"
echo "-----------------------------------------------------------------"
echo "make sure to run the update script to install the configuration"
echo "-----------------------------------------------------------------"
