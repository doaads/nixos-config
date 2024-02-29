{ config, pkgs, ... }:

{
	home.packages = with pkgs; [
		tmux
	];

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
