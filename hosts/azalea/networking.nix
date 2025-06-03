{
  networking = {
    wireless = {
      enable = true;
      networks."vodafoneCFC194".psk = builtins.readFile ./wifi-psk;
      interfaces = [ "wlan0" ];
    };
  };
}
