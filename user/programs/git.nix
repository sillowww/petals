{
  pkgs,
  ...
}:
{
  config = {
    programs.git = {
      enable = true;
      difftastic.enable = true;

      userName = "willow";
      userEmail = "hai@wlo.moe";

      extraConfig = {
        init.defaultBranch = "main";
        rebase.autostash = true;
        push.autoSetupRemote = true;
        pull.rebase = true;
      };
    };

    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
    programs.lazygit = {
      enable = true;
      settings = {
        git = {
          overrideGpg = true;
        };
      };
    };

    home.packages = with pkgs; [
      gfold
    ];
  };
}
