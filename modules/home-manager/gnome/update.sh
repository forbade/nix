rm ./default.nix
dconf dump / > ./dump
nix run nixpkgs#dconf2nix -- -i dump -o default.nix
rm dump
