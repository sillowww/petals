{ pkgs, ... }:

{
  services.udev.packages = with pkgs; [
    android-udev-rules
  ];

  services.gvfs.enable = true;
}
