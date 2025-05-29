{
  programs.home-manager.enable = true;

  home = {
    username = "willow";
    homeDirectory = "/home/willow";
    stateVersion = "25.11";
  };

  imports = [
    ./ctp.nix
    ./apps
    ./packages
    ./programs
    ./desktop
  ];

  xdg.enable = true;
  fonts.fontconfig.enable = true;
}
