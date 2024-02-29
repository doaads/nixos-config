{

	description = "Personal NixOS configuration";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

		home-manager.url = "github:nix-community/home-manager/release-23.11";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { self, nixpkgs, home-manager, ... }:
		let
			# --- USER INFO ---------------------------------
			userSettings = {
				username = "doaads";
			};

			lib = nixpkgs.lib;
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
		in {
			nixosConfigurations = {
				doaads = lib.nixosSystem {
					inherit system;
					modules = [ ./configuration.nix ];
					specialArgs = {
						inherit userSettings;
					};
				};
			};

			homeConfigurations = {
				doaads = home-manager.lib.homeManagerConfiguration {
					inherit pkgs;
					modules = [ ./users/doaads/home.nix ];
					extraSpecialArgs = {
						inherit userSettings;
					};
				};
			};
		};

}
