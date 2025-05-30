{ pkgs, ... }:
{
  home.packages = with pkgs; [
    angband
    crawl
    cataclysm-dda
  ];
}
