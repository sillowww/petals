{
  networking = {
    hostName = "azalea";
    wireless = {
      enable = true;
      networks."vodafoneCFC194".psk = builtins.getEnv "WIFI_PSK";
      interfaces = [ "wlan0" ];
    };
    firewall = {
      allowedTCPPorts = [
        22
        2222
        80
        443
      ];
      allowedUDPPorts = [ ];
      enable = true;
    };
  };
}
