{ pkgs, lib, ... }:
{
  wayland.windowManager.sway = {
    extraConfig = lib.mkAfter ''
      exec ${pkgs.swww}/bin/swww-daemon && _wallpaper
      exec systemctl --user import-environment PATH && systemctl --user restart xdg-desktop-portal.service

      exec swaymsg "workspace 3; exec zeditor;"; assign [class="dev.zed.Zed"] 1
      exec swaymsg "workspace 3; exec foot"; assign [class="foot"] 3
      exec swaymsg "workspace 9; exec thunderbird"; assign [class="thunderbird"] 9
      exec swaymsg "workspace 9; exec spotify"; assign [class="Spotify"] 9
      exec swaymsg "workspace 8; exec keepassxc"; assign [class="org.keepassxc.KeePassXC"] 8

      exec swaymsg "workspace 1; exec firefox"; assign [class="firefox"] 1
      exec swaymsg "workspace 2; exec vesktop;"; assign [class="vesktop"] 1

      exec swaymsg "workspace 8;"
    '';
  };
}
