{ pkgs, ... }:
{
  imports = [
    ./ctp.nix
    ./apps
    ./packages
    ./programs
    ./desktop
  ];
  programs.home-manager.enable = true;

  home = {
    username = "willow";
    homeDirectory = "/home/willow";
    stateVersion = "25.11";
    pointerCursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
      x11 = {
        enable = true;
        defaultCursor = "Adwaita";
      };
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  xdg.enable = true;
  fonts.fontconfig.enable = true;
}
