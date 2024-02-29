
{ config, pkgs, ... }:

{
 home.packages = with pkgs; [
		gnome.gnome-terminal
	];
 programs.gnome-terminal = {
	enable = true;
	showMenubar = true;
	profile."2540f330-5171-459e-8f4e-b7517f352af1" = {
		default = true;
		visibleName = "config";
		showScrollbar = false;
		transparencyPercent = 50;
		font = "Hack Nerd Font 12";
		colors = {
		palette = [
			"#1c2023"
			"#c7ae95"
			"#95c7ae"
			"#aec795"
			"#ae95c7"
			"#c795ae"
			"#95aec7"
			"#c7ccd1"
			"#747c84"
			"#c7ae95"
			"#95c7ae"
			"#aec795"
			"#ae95c7"
			"#c795ae"
			"#95aec7"
			"#f3f4f5"
		];
		backgroundColor = "#1c2023";
		foregroundColor = "#c7ccd1";
		};
	};
 };
}
