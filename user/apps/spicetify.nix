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
    wayland = true;

    theme = spicePkgs.themes.catppuccin;
    colorScheme = config.catppuccin.flavor;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      shuffle
      autoSkip
      powerBar
      autoVolume

      history
      simpleBeautifulLyrics
    ];
    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
    ];
  };
}
