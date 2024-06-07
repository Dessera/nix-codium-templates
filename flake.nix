{
  description = "Project-based Vscodium template instances";

  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs?ref=nixos-unstable"; };
    nix-vscode-extensions = { url = "github:nix-community/nix-vscode-extensions"; };
    flake-parts = { url = "github:hercules-ci/flake-parts"; };
    devshell = { url = "github:numtide/devshell"; };
  };

  outputs =
    inputs@{ self
    , nixpkgs
    , nix-vscode-extensions
    , flake-parts
    , devshell
    , ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [ devshell.flakeModule ];
      # Development shell
      perSystem = { config, pkgs, system, ... }:
        let
          codium-extensions = nix-vscode-extensions.extensions."${system}";
        in
        rec {
          formatter = pkgs.nixpkgs-fmt;
          devshells.default = {
            packages = with pkgs; [ nil nixpkgs-fmt packages.code-nix ];
          };

          packages.code-flutter = import ./packages/flutter {
            inherit pkgs;
            inherit codium-extensions;
          };

          packages.code-nix = import ./packages/nix {
            inherit pkgs;
            inherit codium-extensions;
          };

          packages.code-cpp = import ./packages/cpp {
            inherit pkgs;
            inherit codium-extensions;
          };

          legacyPackages = {
            utils = import ./utils;
          };
        };
    };
}
