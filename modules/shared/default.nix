{ inputs, ... }:
{
  imports = [
    ./nix.nix
    ./services.nix
    ./packages.nix
  ];

  system.stateVersion = "25.11";
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };

  programs.fish.enable = true;
  security.rtkit.enable = true;
  security.polkit.enable = true;
}
