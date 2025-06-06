{ pkgs, ... }:
{
  imports = [
    ./fonts.nix
    ./tooling.nix
  ];

  home.packages = with pkgs; [
    zellij
    dmenu
    imagemagick
    swww
    waybar
    waybar-mpris

    grim
    slurp

    gdk-pixbuf
    libwebp
    webp-pixbuf-loader
  ];
}
