{
  lib,
  config,
  pkgs,
  ...
}:
{
  home.activation.downloadCatppuccinTheme = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p ~/.config/sway
    ${pkgs.curl}/bin/curl -o ~/.config/sway/_${config.catppuccin.flavor} https://raw.githubusercontent.com/catppuccin/i3/main/themes/catppuccin-${config.catppuccin.flavor}
  '';

  wayland.windowManager.sway.extraConfig = lib.mkAfter ''
    include _catppuccin-${config.catppuccin.flavor}

    gaps inner 4
    gaps outer 2
    smart_gaps on

    default_border none
    default_floating_border none

    corner_radius 8
    blur enable
    blur_radius 3
    blur_passes 3
    default_dim_inactive 0.075

    default_border pixel 1

    shadows enable
    shadow_color #00000040
    shadow_inactive_color #00000033

    layer_effects "moe.iri.swaync.overlay" blur enable; blur_ignore_transparent enable
    layer_effects "swaync-notification-window" blur enable; blur_ignore_transparent enable
    layer_effects "swaync-control-center" blur enable; blur_ignore_transparent enable
    layer_effects "swayosd" blur enable; blur_ignore_transparent enable
    layer_effects "sylph" blur enable; blur_ignore_transparent enable
  '';
}
