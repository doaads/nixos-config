{ config, pkgs, userSettings, ... }:

{
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;

  home.stateVersion = "23.11";

  imports = [ 
	../../packages/tmux.nix		# tmux configuration
	../../packages/gnome-terminal.nix	# gnome-terminal configuration
  ];

  home.packages = with pkgs; [
	# Shell
	zsh 

	# Browser
	firefox
	
	# Text editors
	vim neovim

	# Git
	git github-cli


	# Utilities
	zip unzip ripgrep xclip gnumake valgrind

	# Development
	gcc
	rustc
	cargo
	nodejs
	libclang
	
	(python3.withPackages (p: with p; [
		pandas
		requests
	]))

	# VM
	qemu

	# Network
	aircrack-ng
	wireshark
	wget
	networkmanager
	nmap
	iperf

	# Fonts
	(nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Hack" ]; })

    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
