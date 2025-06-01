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

      signing = {
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPWD6wk95qNhk/36vEH34qIRp/TPCcQ+D+u5Xd9/N0m1 hai@wlo.moe";
        signByDefault = true;
      };

      extraConfig = {
        gpg.format = "ssh";
        gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
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
