#!/bin/sh
# This script is used to install the nixos configuration on a new machine
# It will link the configuration files to the current directory and install home-manager
# sudo is required to link the configuration files

set -e

#process args

#help message

if [ "$1" = "--help" ] || [ "$1" = "-h" ] || [ "$2" = "--help" ] || [ "$2" = "-h" ]; then
	echo "Usage: ./install.sh [flags]"
	echo "Flags:"
	echo "  -f, --full: full installation, will also install the nixos configuration at /etc/nixos"
	echo "  -n, --no-link: skip linking of configuration.nix"
	echo "  -fn, -nf: full installation with symlink skip"
	exit 0
fi

#if -f, --full in $1 or $2 then add "f" to type
if [ "$1" = "-f" ] || [ "$1" = "--full" ] || [ "$2" = "-f" ] || [ "$2" = "--full" ]; then
	echo "full installation."
	type="f"
fi

#if -n, --no-link in $1 or $2 then add "n" to type
if [ "$1" = "-n" ] || [ "$1" = "--no-link" ] || [ "$2" = "-n" ] || [ "$2" = "--no-link" ]; then
	echo "skipping configuration links"
	nolink="n"
fi

type="$type$nolink"

#if -fn or -nf add both
if [ "$1" = "-fn" ] || [ "$1" = "-nf" ] || [ "$2" = "-fn" ] || [ "$2" = "-nf" ]; then
	echo "full installation with symlink skip"
	type="fn"
fi


# if -f (--full) flag is provided, the script will also install the nixos configuration at /etc/nixos
if [ "$type" = "f" ] || [ "$type" = "fn" ]; then
	echo "installing nixos configuration"
	sudo mv /etc/nixos/configuration.nix ./userconfig/config-backup/configuration-backup-fullinstall.nix
	echo "backup created"
	sudo cp ./userconfig/configuration.nix /etc/nixos/configuration.nix

fi

echo "linking hardware-configuration.nix to current dir"
ln -s /etc/nixos/hardware-configuration.nix ./hardware-configuration.nix

# the setup will use an existing configuration.nix file
# if you prefer to use the preconfigured one - it is available in useconfig directory
# if you don't want the config linked - run with -n or --no-link flag

if [ "$type" = "n" ] || [ "$type" = "fn" ]; then
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
