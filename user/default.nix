{
  self,
  self',
  inputs,
  inputs',
  hostname,
  ...
}:
{
  config.home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.willow = ./home.nix;
    backupFileExtension = "bk";

    extraSpecialArgs = {
      inherit
        self
        self'
        inputs
        inputs'
        hostname
        ;
    };
  };
}
