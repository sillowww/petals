{
  hostname,
  pkgs,
  lib,
  ...
}:
let
  isDesktop = hostname == "dahlia";
in
{
  imports =
    [
      ./packages
      ./programs
      ./scripts
    ]
    ++ (
      if isDesktop then
        [
          ./apps
          ./ctp.nix
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
    pointerCursor = lib.mkIf {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
      x11 = {
        enable = true;
        defaultCursor = "Adwaita";
      };
    };
    sessionVariables = lib.mkIf {
      XDG_DESKTOP_PORTAL = "wlr";
    };

    file.".ssh/allowed_signers".text = ''
      willow ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPWD6wk95qNhk/36vEH34qIRp/TPCcQ+D+u5Xd9/N0m1
    '';

  };

  dconf.settings = lib.mkIf {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = lib.mkIf {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  xdg.enable = true;
  fonts.fontconfig.enable = true;
}
