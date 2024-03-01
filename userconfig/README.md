# Pre-defined config directory

* Since the switch is done impurely, issues with the config may arise.
* There are two ways to fix these issues.

1. The first way is to copy the ``configuration.nix`` file from this directory directly to the root dir.
2. The second way is to use the provided script to install ``configuration.nix`` in ``/etc/nixos`` and backup the current configuration in the ``config-backup`` dir.
