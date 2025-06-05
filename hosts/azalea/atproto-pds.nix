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
}
