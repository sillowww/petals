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

      otherBar = {
        name = "otherBar";
        layer = "bottom";
        position = "bottom";
        height = 4;
        output = [ "HDMI-A-1" ];

        modules-left = [
          "sway/workspaces"
        ];

        "sway/workspaces" = {
          "persistent-workspaces" = {
            "2" = [ ];
            "4" = [ ];
            "6" = [ ];
            "8" = [ ];
          };
        };

      };
    };

    style = lib.mkAfter (builtins.readFile ./index.scss);
  };
}
