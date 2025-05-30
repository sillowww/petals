{ pkgs, ... }:

{
  programs.foot = {
    enable = true;
    package = pkgs.foot;

    settings = {
      main = {
        font = "ZedMono NF";
        pad = "4x4";
      };
      cursor = {
        style = "beam";
        color = "eff1f5 dc8a78";
      };
    };
  };
}
