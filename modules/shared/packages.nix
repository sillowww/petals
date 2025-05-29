{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    htop
    vim
    wget
    curl
    git
    just
    openssl
    imv
    fuse3
    wirelesstools
    jq
    mpv
    unzip
    file
    playerctl
    gnupg
    killall
    imagemagick
    gnome-keyring
    libsecret

    fastfetch
    kittysay
    hyfetch

    nautilus
    xfce.thunar

  ];
}
