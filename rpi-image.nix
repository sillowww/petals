# TODO: move this into flake.
{
  ...
}:
{
  imports = [
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64.nix>
  ];

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPWD6wk95qNhk/36vEH34qIRp/TPCcQ+D+u5Xd9/N0m1 hai@wlo.moe"
  ];

  networking = {
    useDHCP = false;
    interfaces.wlan0.useDHCP = true;

    wireless = {
      enable = true;
      networks = {
        "vodafoneCFC194" = {
          pskRaw = "354e653b8070ca7e582864293abdde6b74cbc6402adb7778319186c6d077b1ae";
        };
      };
    };
  };

  boot.loader = {
    grub.enable = false;
    generic-extlinux-compatible.enable = true;
  };

  system.stateVersion = "25.11";
}
