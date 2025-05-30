{ config, ... }:
let
  vesktopSettings = ./settings.json;
in
{
  home.file = {
    "${config.home.homeDirectory}/.config/vesktop/settings/settings.json".source = vesktopSettings;
    "${config.home.homeDirectory}/.config/vesktop/settings/quickCss.css".text = ''
      @import url("https://catppuccin.github.io/discord/dist/catppuccin-${config.catppuccin.flavor}-${config.catppuccin.accent}.theme.css");
    '';
  };
}
