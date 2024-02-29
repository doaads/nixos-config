{ config, pkgs, userSettings, ... }:

{
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;

  home.stateVersion = "23.11";

  imports = [ ./tmux.nix ];

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
	zip unzip ripgrep xclip gnumake

	# Development
	gcc rustc cargo
	(python3.withPackages (p: with p; [
		pandas
		requests
	]))

	# VM
	qemu

	# Network
	aircrack-ng wireshark wget networkmanager nmap

    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/doaads/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

 
}
