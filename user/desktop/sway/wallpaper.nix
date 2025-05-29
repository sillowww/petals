{ pkgs, lib, ... }:
let
  randomWallpaper = pkgs.writeShellScriptBin "_random-wallpaper" ''
    wallpaper=$(find ~/Pictures/Wallpapers -type f -name "*.jpg" -o -name "*.png" -o -name "*.webp" -o -name "*.jpeg" | ${pkgs.coreutils}/bin/shuf -n 1)
    ${pkgs.sway}/bin/swaymsg output "*" bg "$wallpaper" fill
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
