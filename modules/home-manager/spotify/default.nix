{ inputs, pkgs, ... }:

{

import = [ inputs.spicetify-nix.homeManagerModules.default ];

home.packages = with pkgs; [ spotify ];

programs.spicetify =
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
	{
		enable = true;
		theme = spicePkgs.themes.fluent;
		enabledExtensions = with spicePkgs.extensions; [
		  adblockify
		  adblock
		  shuffle
		];
	};

}