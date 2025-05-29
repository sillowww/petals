{
  lib,
  config,
  inputs,
  ...
}:
let
  inherit (lib) mkOption types;
in
{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  options.palette = mkOption {
    type = types.attrs;
  };

  config = {
    catppuccin = {
      flavor = "mocha";
      accent = "mauve";
      enable = true;
    };

    palette = lib.importJSON (config.catppuccin.sources.palette + "/palette.json");
  };
}
