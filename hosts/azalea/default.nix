{
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/shared
    ../../user
    ./core.nix
    ./networking.nix
  ];

  environment.systemPackages = with pkgs; [
    vim
    wget
    neofetch
    git
  ];

  users = {
    mutableUsers = false;
    users."willow" = {
      isNormalUser = true;
      hashedPassword = null;
      extraGroups = [
        "wheel"
        "docker"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPWD6wk95qNhk/36vEH34qIRp/TPCcQ+D+u5Xd9/N0m1 hai@wlo.moe"
      ];
    };
    users."meow" = {
      isNormalUser = true;
      shell = pkgs.fish;
      hashedPassword = null;
    };
    users.root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPWD6wk95qNhk/36vEH34qIRp/TPCcQ+D+u5Xd9/N0m1 hai@wlo.moe"
    ];
  };

}
