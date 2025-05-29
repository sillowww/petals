{ pkgs, ... }:

{
  programs = {
    nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}
