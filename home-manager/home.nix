{ inputs, pkgs, config, ... }:

{
  home.username = "justin";
  home.homeDirectory = "/home/justin";
  home.stateVersion = "24.11"; 

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [

    pkgs.spotify

    # NUR Packages

  ];

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Program Installation
  # NOTE: program configurations are stored inside of ../modules 
  programs.firefox.enable = true;
  programs.vscode.enable = true;
  programs.brave.enable = true;
  programs.emacs.enable = true;

  # Inactive Applications

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.file = {

    ".emacs.d/config.org" = {
	source = ./emacs/config.org;
    };

    ".emacs.d/init.el" = {
	source = ./emacs/init.el;
    };

    ".emacs.d/early-init.el" = {
	source = ./emacs/early-init.el;
    };

    ".bashrc" = {
	source = ./shell/.bashrc;
    };

  };

}
