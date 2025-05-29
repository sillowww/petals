{
  pkgs,
  lib,
  ...
}:

{
  programs.zed-editor = {
    enable = true;

    extensions = [
      "html"
      "biome"
      "toml"
      "vue"
      "scss"
      "nix"
      "just"
    ];

    userSettings = {
      format_on_save = "on";
      theme = {
        mode = "system";
        light = lib.mkForce "Catppuccin Latte";
      };

      auto_update = false;
      collaboration_panel.button = false;

      ui_font_family = "JetBrainsMono Nerd Font";
      buffer_font_family = "JetBrainsMono Nerd Font";
      buffer_font_size = 14;

      languages = {
        Nix.formatter.external = {
          command = "nixfmt";
          arguments = [
            "--quiet"
            "--"
          ];
        };
      };

      lsp = {
        nix = {
          binary = {
            path_lookup = true;
          };
        };

        "rust-analyzer" = {
          binary = {
            path = "${pkgs.nix}/bin/nix";
            arguments = [
              "develop"
              "--extra-experimental-features"
              "nix-command"
              "--extra-experimental-features"
              "flakes"
              "--command"
              "rust-analyzer"
            ];
          };
          settings = {

            server = {
              extraEnv = {
                RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
              };
            };
            diagnostics = {
              enable = true;
              styleLints.enable = true;
            };
            checkOnSave = true;
            check = {
              command = "clippy";
              features = "all";
            };
            cargo = {
              buildScripts.enable = true;
              features = "all";
            };
            inlayHints = {
              bindingModeHints.enable = true;
              closureStyle = "rust_analyzer";
              closureReturnTypeHints.enable = "always";
              discriminantHints.enable = "always";
              expressionAdjustmentHints.enable = "always";
              implicitDrops.enable = true;
              lifetimeElisionHints.enable = "always";
              rangeExclusiveHints.enable = true;
            };
            procMacro.enable = true;
            rustc.source = "discover";

            files = {
              excludeDirs = [
                ".cargo"
                ".direnv"
                ".git"
                "node_modules"
                "target"
              ];
            };
          };
        };
      };

    };
  };
}
