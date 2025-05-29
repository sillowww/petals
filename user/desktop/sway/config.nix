{ pkgs, lib, ... }:
let
  workspaces = lib.genAttrs (map toString (lib.range 1 10)) (
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
in
{
  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    wrapperFeatures.gtk = true;
    checkConfig = false;

    # extraConfig = lib.concatStringsSep "\n" (
    #   lib.mapAttrsToList (ws: output: "workspace ${ws} output ${output}") workspaces
    # );

    extraConfig = lib.concatStringsSep "\n" (
    lib.mapAttrsToList (ws: output: "workspace ${ws} output ${output}") workspaces
    );
  };
}
