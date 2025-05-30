{ pkgs, ... }:
{
  programs.foot = {
    enable = true;
    package = pkgs.foot;

    settings = {
      main = {
        font = "ZedMono NF Extd Med";
        pad = "4x4";
      };
      cursor = {
        style = "beam";
      };
      colors = {
        alpha = 0.975;
      };
    };
  };
}
