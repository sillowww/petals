{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (
      if pkgs.stdenv.hostPlatform.system == "x86_64-linux" then
        # my poor cpu is too old for `pkgs.bun`.
        (callPackage ./bun-baseline.nix { })
      else
        bun
    )
    deno
    nodejs_latest

    python314
    uv

    stylua
    lua
    lune
    luau

    # rust
    cargo
    rustc
    rustfmt
    rust-analyzer

    # nix
    nil
    nixd
    nixfmt-rfc-style

    # go
    go_latest
    gotools
    gopls

    # other
    gcc
    glibc
    temurin-bin-17
    android-tools
    sqlite
    nmap
    dig
  ];
}
