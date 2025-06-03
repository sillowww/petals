{ config, pkgs, ... }:
let
  hostname = config.networking.hostName or "unknown";
  isDesktop = hostname == "dahlia";
in
{
  imports =
    [
      ./ctp.nix
      ./packages
      ./programs
      ./scripts
    ]
    ++ (
      if isDesktop then
        [
          ./apps
          ./desktop
        ]
      else
        [ ]
    );

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
    sessionVariables = {
      XDG_DESKTOP_PORTAL = "wlr";
    };

    file.".ssh/allowed_signers".text = ''
      willow ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPWD6wk95qNhk/36vEH34qIRp/TPCcQ+D+u5Xd9/N0m1
    '';

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
