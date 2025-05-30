{ pkgs, lib, ... }:
let
  randomWallpaper = pkgs.writeShellScriptBin "_random-wallpaper" ''
    wallpaper=$(find ~/Pictures/Wallpapers -type f -name "*.jpg" -o -name "*.png" -o -name "*.webp" -o -name "*.jpeg" | ${pkgs.coreutils}/bin/shuf -n 1)
    ${pkgs.swww}/bin/swww img "$wallpaper" --transition-bezier .05,.4,.49,.96 -t grow
  '';
in
{
  home.file."Pictures/Wallpapers" = {
    source = ../../../assets/wallpapers;
    recursive = true;
  };

  home.packages = [ randomWallpaper ];

  wayland.windowManager.sway.extraConfig = lib.mkAfter ''
    exec _random-wallpaper
  '';
}
