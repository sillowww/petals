_default:
  @just --list --unsorted

build HOST *args:
  sudo nixos-rebuild build --flake .#{{HOST}} {{args}}

switch HOST *args:
  sudo nixos-rebuild switch --flake .#{{HOST}} {{args}}

update:
  nix flake update

check:
  nix flake check
