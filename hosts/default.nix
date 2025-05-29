{ inputs, ... }:
{
  flake.nixosConfigurations = {
    dahlia = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./dahlia
        ./dahlia/_hware-config.nix
        inputs.home-manager.nixosModules.home-manager
      ];
      specialArgs = {
        inherit inputs;
        inputs' = builtins.mapAttrs (_: flake: {
          legacyPackages = flake.legacyPackages."x86_64-linux" or { };
          packages = flake.packages."x86_64-linux" or { };
        }) inputs;
      };
    };
  };
}
