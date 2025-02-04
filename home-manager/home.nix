{ config, pkgs, ... }:

{
  home.username = "justin";
  home.homeDirectory = "/home/justin";
  home.stateVersion = "24.11"; 

  nixpkgs.config.allowUnfree = true;

  home.packages = [
    pkgs.hello
  ];

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Program Installation
  # NOTE: program configurations are stored inside of ../modules 
  programs.brave.enable = true;
  programs.vscode.enable = true;
  programs.spotifyd.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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

}
