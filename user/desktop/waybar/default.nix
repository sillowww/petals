{ lib, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "sway-session.target";

    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        height = 32;

        output = [ "DP-1" ];

        modules-left = [
          "sway/workspaces"
          "sway/window"
        ];
        modules-center = [
          "mpris"
        ];
        modules-right = [
          "clock"
          "network"
          "pulseaudio"
          "tray"
        ];

        mpris = {
          format = "{player_icon} {status_icon} {title} - {artist}";
          format-paused = "{player_icon} {status_icon} {title} - {artist}";
          format-stopped = "";
          player-icons = {
            "spotify" = "";
          };
          status-icons = {
            "Playing" = "▶";
            "Paused" = "⏸";
          };
          player = "spotify";
        };

      };
    };

    style = lib.mkAfter (builtins.readFile ./index.css);
  };
}
