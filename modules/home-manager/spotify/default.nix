{ config, lib, ... }:

{

programs.spicetify =
let
	spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
	{
		enable = true;
		# theme = ;
		enabledExtensions = with spicePkgs.extensions; [
		  adblockify
		  adblock
		  shuffle
		]
	}

}