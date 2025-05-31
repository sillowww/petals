{ lib, ... }:
let
  programs = {
    term = "foot";
    menu = "dmenu_run";
    screenshot = {
      default = "~/.local/bin/_screenshot";
      noCandy = "~/.local/bin/_screenshot --radius 0 --padding 0 --no-shadow";
    };
  };

  workspaces = lib.genAttrs (map toString (lib.range 1 9)) (
    i:
    if
      lib.elem (lib.toInt i) [
        1
        3
        5
        7
        9
      ]
    then
      "DP-1"
    else
      "HDMI-A-1"
  );

  wsBinds = lib.mapAttrs' (ws: output: {
    name = "${super}+${ws}";
    value = "workspace ${ws}";
  }) workspaces;

  wsMoveBinds = lib.mapAttrs' (ws: output: {
    name = "${super}+Shift+${ws}";
    value = "move container to workspace ${ws}";
  }) workspaces;

  super = "Mod4";
  dirKeys = {
    left = "q";
    right = "w";
    up = "a";
    down = "s";
  };

  dirBinds = lib.mapAttrs' (dir: key: {
    name = "${super}+${key}";
    value = "focus ${dir}";
  }) dirKeys;

  dirMoveBinds = lib.mapAttrs' (dir: key: {
    name = "${super}+Shift+${key}";
    value = "move ${dir}";
  }) dirKeys;
in
{
  wayland.windowManager.sway = {
    extraConfig = lib.mkAfter ''
      # workspaces
      ${lib.concatStringsSep "\n" (
        lib.mapAttrsToList (key: cmd: "bindsym ${key} ${cmd}") (
          wsBinds // wsMoveBinds // dirBinds // dirMoveBinds
        )
      )}

      ${lib.concatStringsSep "\n" (
        lib.mapAttrsToList (ws: output: "workspace ${ws} output ${output}") workspaces
      )}

      input type:keyboard {
          xkb_layout gb
          xkb_options caps:ctrl_modifier,
      }

      # meow
      bindsym ${super}+Shift+e kill
      bindsym ${super}+Shift+c reload;
      bindsym ${super}+Escape exec swaynag -t warning -m 'exit' -B 'yes' 'swaymsg exit'
      floating_modifier ${super} normal

      bindsym ${super}+f fullscreen
      bindsym ${super}+Shift+space floating toggle
      bindsym ${super}+space focus mode_toggle

      # focus & moving
      # bindsym ${super}+${dirKeys.left} focus left
      # bindsym ${super}+${dirKeys.right} focus right
      # bindsym ${super}+${dirKeys.up} focus up
      # bindsym ${super}+${dirKeys.down} focus down

      # bindsym ${super}+${dirKeys.left}+Shift move left
      # bindsym ${super}+${dirKeys.right}+Shift move right
      # bindsym ${super}+${dirKeys.up}+Shift move up
      # bindsym ${super}+${dirKeys.down}+Shift move down

      bindsym ${super}+Shift+Tab move scratchpad
      bindsym ${super}+Tab scratchpad show

      # layout
      bindsym ${super}+z splith
      bindsym ${super}+x splitv
      bindsym ${super}+e layout stacking
      bindsym ${super}+r layout tabbed
      bindsym ${super}+c layout toggle split

      # launch things
      bindsym ${super}+t exec ${programs.term}
      bindsym ${super}+d exec ${programs.menu}
      bindsym ${super}+Shift+d exec ${programs.screenshot}

      # media
      bindsym --locked XF86AudioPlay exec playerctl play-pause
      bindsym --locked XF86AudioNext exec playerctl next
      bindsym --locked XF86AudioPrev exec playerctl previous
      bindsym --locked XF86AudioStop exec playerctl stop

      bindsym --locked XF86AudioRaiseVolume exec pactl set-sink-volume @DEFAULT_SINK@ +5%
      bindsym --locked XF86AudioLowerVolume exec pactl set-sink-volume @DEFAULT_SINK@ -5%
      bindsym --locked XF86AudioMicMute exec pactl set-sink-mute @DEFAULT_SINK@ toggle
    '';
  };
}
