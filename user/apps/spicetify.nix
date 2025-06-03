{
  config,
  inputs,
  inputs',
  ...
}:
let
  spicePkgs = inputs'.spicetify-nix.legacyPackages;
in
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = config.catppuccin.flavor;
    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      adblockify
      shuffle
      autoSkip
      powerBar
      autoVolume
    ];
  };
}
