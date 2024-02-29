{ config, pkgs, userSettings, ... }:

{
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;

  home.stateVersion = "23.11";

  imports = [ ../../packages/tmux.nix ];

  home.packages = with pkgs; [
	# Shell
	zsh 
	#gnome.gnome-terminal

	# Browser
	firefox
	
	# Text editors
	vim neovim

	# Git
	git github-cli


	# Utilities
	zip unzip ripgrep xclip gnumake

	# Development
	gcc rustc cargo nodejs
	(python3.withPackages (p: with p; [
		pandas
		requests
	]))

	# VM
	qemu

	# Network
	aircrack-ng wireshark wget networkmanager nmap

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

  #programs.gnome-terminal = {
  #  showMenubar = false;
  #  profile."2540f330-5171-459e-8f4e-b7517f352af1" = {
  #  	showScrollbar = false;
  #  	transparencyPercent = 50;
  #  };
  #};

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
