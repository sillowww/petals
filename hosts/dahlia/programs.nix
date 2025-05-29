{ pkgs, ... }:

{
  programs = {
    nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
    };

    dconf.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}
