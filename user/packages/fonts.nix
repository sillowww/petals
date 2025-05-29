{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nerd-fonts.zed-mono
    nerd-fonts.jetbrains-mono
    jetbrains-mono
  ];
}
