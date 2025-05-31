{
  lib,
  pkgs,
  config,
  ...
}:
{
  home = {
    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
    ];

    file = builtins.listToAttrs (
      builtins.map (name: {
        name = ".local/bin/_${lib.removeSuffix ".sh" (builtins.baseNameOf name)}";
        value = {
          source = lib.getExe (
            pkgs.writeShellApplication {
              name = builtins.baseNameOf name;
              text = builtins.readFile ./${name};

              bashOptions = [
                "errexit"
                "pipefail"
              ];
            }
          );
        };
      }) (builtins.filter (n: !lib.hasSuffix ".nix" n) (builtins.attrNames (builtins.readDir ./.)))
    );
  };
}
