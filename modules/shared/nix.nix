{ ... }:
{
  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 3d";
    };

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

}
