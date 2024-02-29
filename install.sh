#!/bin/sh

if [ -f "hardware-configuration.nix" ]; then
	echo "hardware-configuration.nix already copied"
else
	echo "hardware-configuration.nix not found, copying"
	cp /etc/nixos/hardware-configuration.nix ./
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


./update
