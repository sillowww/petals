{ pkgs, ... }:
{
  imports = [
    ./fonts.nix
    ./tooling.nix
  ];

  home.packages = with pkgs; [
    zellij
    dmenu

    gdk-pixbuf
    libwebp
    webp-pixbuf-loader
  ];
}
