# Personal NixOS configuration

WIP NixOS configuration with flakes and home-manager.

## Installation

An installation script is provided at ``install.sh``. It will set up symlinks for ``/etc/nixos`` files and install home-manager
Full installation (with personal configuration.nix) can be done by providing a -f flag to the script.

## Usage

Configuration can be automatically applied with the following command:

```sh
nix flake update
sudo nixos-rebuild switch --flake .#<hostname> --impure
home-manager switch --flake
```

which can also be done with the ``update`` script, by providing a -r flag.

As the ``configuration.nix`` is a symlink to /etc/nixos, using the update flag will update the home configuration without rebuilding the flakes, useful for personal projects, for users without sudo access
