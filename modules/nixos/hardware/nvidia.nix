{ config, pkgs, ... }:

{

  hardware.graphics = {
	enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
	modesetting.enable = true;			# Necessary for wayland
	powerManagement.enable = false;
	powerManagement.finegrained = false;
	open = false;					# Open-source drivers
	nvidiaSettings = true;				# Settings menu
	nvidiaPersistenced = true;			# Fixes a glitch? (https://www.reddit.com/r/NixOS/comments/18n21n8/how_do_i_install_the_stupid_proprietary_nvidia/)
	forceFullCompositionPipeline = true;
	
	# Specify stable-version of drivers considering the current setup is using a 1050Ti
	package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

}
