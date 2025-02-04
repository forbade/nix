{ config, pkgs, ... }:

{
  programs.chromium = {
	enable = true;
	package = pkgs.brave;

	initialPrefs = {
	  "homepage" = "https://www.google.com";
	  "homepage_is_newtabpage" = true;
	  "sync_promo" = {
		"show_on_first_run_allowed" = false;
	  };
	};

	extraOpts = {
	  "browserSignin" = 0;
	  "SyncDisabled" = false;
	  "PasswordManagerEnabled" = false;
	};

	extensions = [
	  { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin	
	];

	commandLineArgs = [
	  # NOTE: flag is deprecated it seems
	  # "--disable-features=WebRtcAllowInputVolumeAdjustment"	
	];
  };
}
