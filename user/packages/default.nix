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

    gdk-pixbuf
    libwebp
    webp-pixbuf-loader
  ];
}
