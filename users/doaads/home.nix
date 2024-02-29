{ config, pkgs, userSettings, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "doaads";
  home.homeDirectory = "/home/doaads";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
	# Browser
	firefox
	
	# Text editors
	vim neovim

	# Git
	git github-cli


	# Utilities
	zip unzip ripgrep xclip gnumake

	# Development
	python3 gcc rustc cargo

	# VM
	qemu

	# Network
	aircrack-ng wireshark wget networkmanager nmap

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
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

  programs.tmux = {
	enable = true;
	clock24 = true;
	extraConfig = ''
		set -g default-terminal "screen-256color"
		set -g mouse on
		set -sg escape-time 10
		set-option -g default-shell /run/current-system/sw/bin/zsh

		set -g @plugin 'tmux-plugins/tpm'

		set -g @plugin 'christoomey/vim-tmux-navigator'
		set -g @plugin 'jimeh/tmux-themepack'
		set -g @plugin 'tmux-plugins/tmux-resurrect'
		set -g @plugin 'tmux-plugins/tmux-continuum'

		set -g @themepack 'powerline/default/gray' # use this theme for tmux

		set -g @resurrect-capture-pane-contents 'on'
		set -g @continuum-restore 'on'

		run '~/.tmux/plugins/tpm/tpm'
	'';
  };

}
