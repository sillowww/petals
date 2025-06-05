{ lib, ... }:
let
  mkPdsVhost = hostName: {
    inherit hostName;
    extraConfig = ''
      tls {
        on_demand
      }
      reverse_proxy localhost:8090
    '';
  };

  pdsHostnames = [
    "pds.wlo.moe"
    "*.pds.wlo.moe"
  ];

  pdsVirtualHosts = lib.listToAttrs (
    map (hn: {
      name = hn;
      value = mkPdsVhost hn;
    }) pdsHostnames
  );
in
{
  services.pds = {
    enable = true;
    pdsadmin.enable = true;
    environmentFiles = [
      "/etc/pds/pds.env"
    ];
    settings = {
      PDS_HOSTNAME = "pds.wlo.moe";
      PDS_PORT = 8090;
      PDS_DATA_DIRECTORY = "/var/lib/pds";
    };
  };

  services.caddy = {
    enable = true;
    email = "hai@wlo.moe";
    virtualHosts = pdsVirtualHosts;
    globalConfig = ''
        on_demand_tls {
      		ask http://localhost:8090/tls-check
       	}
    '';
  };
}
