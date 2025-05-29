{ pkgs, ... }:
{
  imports = [
    ./spicetify.nix
    ./git.nix
  ];

  programs = {
    fish.enable = true;
  };

}
