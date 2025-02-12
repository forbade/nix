{
	description = "Multi-host configuration for MacOS and NixOS systems."; 

	# Git repositories e.g. specific channels that would be otherwise used on default w/o flakes
	inputs = { 
		nixpkgs.url = "nixpkgs/nixos-24.11";
		home-manager.url = "github:nix-community/home-manager/release-24.11";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";			# To assure that home-manager is using the same nixpkgs branch as we are using in this flake.
		mic92.url = "github:Mic92/nur-packages";
	};
	
	# Receives inputs and systematizes a built system configuration
	outputs = { self, nixpkgs, home-manager, mic92, ... }@inputs:
	let
		lib = nixpkgs.lib;
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
	in	
	{ 
		nixosConfigurations = {
			nixos = lib.nixosSystem {
				inherit system;
				modules = [ 
					    ./nixos/core.nix 
					    ./modules/nixos/gnome/default.nix
					  ];
			}; 	
		};
		homeConfigurations = {
			justin = home-manager.lib.homeManagerConfiguration {
				# SEARCHME: Why does homeManagerConfiguration need to inherit this specific package set (which requires architecture)
				inherit pkgs;
				modules = [ 
					    ./home-manager/home.nix 
					    ./modules/home-manager/gnome/default.nix
					    ./modules/home-manager/chromium/brave.nix
					  ];
			}; 	
		};
	};
}
