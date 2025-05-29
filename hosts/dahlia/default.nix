{
  pkgs,
  ...
}:

{
  imports = [
    ../../modules/shared
    ../../user

    ./virtualisation.nix
    ./programs.nix
    ./services.nix
  ];

  time.timeZone = "Europe/London";
  users.users.willow = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "adbusers"
      "plugdev"
    ];
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.polkit-kde-agent
    wlroots
    wl-clipboard
  ];

  hardware.enableRedistributableFirmware = true;
  hardware.graphics.enable = true;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    networkmanager.enable = true;
    hostName = "dahlia";
    firewall = {
      allowedTCPPorts = [
        8080
        8081
      ];
      allowedTCPPortRanges = [
        {
          from = 5173;
          to = 5180;
        }
        {
          from = 4173;
          to = 4180;
        }
      ];
    };
  };

}
