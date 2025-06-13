{ pkgs, lib, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    configPath = "/dev/null";
  };

  home.file.".config/rofi/config.rasi".text = lib.mkForce ''
    configuration {
      modes: [ "window", "drun", "ssh", "recursivebrowser", "filebrowser" ];
      terminal: "${pkgs.foot}/bin/foot";
      xoffset: 0;
      yoffset: 0;
      recursivebrowser {
        filter-regex: "(/|^)(node_modules|\\.git|dist|.cargo|.npm|BeeperTexts|.mozilla|.var|.pki|.thunderbird|.nix-defexpr|.steam|build|out|target|\\.venv|\\.mypy_cache|\\.pytest_cache|\\.idea|\\.vscode|__pycache__|coverage|logs|tmp)(/|$)|(.*cache.*|.*\\.o)";
      }
    }

    @theme "custom"
  '';

}
