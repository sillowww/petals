{
  networking = {
    hostname = "azalea";
    wireless = {
      enable = true;
      networks."vodafoneCFC194".psk = builtins.getEnv "WIFI_PSK";
      interfaces = [ "wlan0" ];
    };
  };
}
