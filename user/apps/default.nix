{ pkgs, ... }:
{
  imports = [
    ./vesktop
    ./zed.nix
    ./foot.nix
    ./games.nix
    ./spicetify.nix
    ./firefox.nix
    ./obsidian.nix
  ];

  home.packages = with pkgs; [
    foot

    lite-xl
    vesktop
    beeper
    thunderbird
    nextcloud-client
    keepassxc

    obs-studio
    obs-studio-plugins.obs-vkcapture
    obs-studio-plugins.obs-pipewire-audio-capture
    obs-studio-plugins.wlrobs
  ];
}
