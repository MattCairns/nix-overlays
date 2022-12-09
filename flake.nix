/* {
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let lib = nixpkgs.lib;
            pkgs = nixpkgs.legacyPackages.${system};
            packages = (import ./default.nix { inherit pkgs lib; });
        in {
          overlay = self: super: packages;
          inherit packages;
        });
} */
{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
    in
    rec {
      /* # Your custom packages
      # Acessible through 'nix build', 'nix shell', etc
      libzmq3-dev = nixpkgs.legacyPackages.${system}.callPackage ./pkgs/libzmq3-dev { };
      argparse = nixpkgs.legacyPackages.${system}.callPackage ./pkgs/argparse { };
      yaml-cpp = nixpkgs.legacyPackages.${system}.callPackage ./pkgs/yaml-cpp { };
      googlebench = nixpkgs.legacyPackages.${system}.callPackage ./pkgs/googlebench { };
      flatbuffers = nixpkgs.legacyPackages.${system}.callPackage ./pkgs/flatbuffers { };
      spdlog = nixpkgs.legacyPackages.${system}.callPackage ./pkgs/spdlog { };

      xplorer-flatbuffers = nixpkgs.legacyPackages.${system}.callPackage ./pkgs/xplorer-flatbuffers { };
      liboorb = nixpkgs.legacyPackages.${system}.callPackage ./pkgs/liboorb { };
      libooraf = nixpkgs.legacyPackages.${system}.callPackage ./pkgs/libooraf { };
      libipc = nixpkgs.legacyPackages.${system}.callPackage ./pkgs/libipc { };
 */
      legacyPackages = forAllSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              self.overlays.default
            ];
          };
        in {
          libzmq3-dev = pkgs.libzmq3-dev;
          argparse = pkgs.argparse;
          yaml-cpp = pkgs.yaml-cpp;
          googlebench = pkgs.googlebench;
          flatbuffers = pkgs.flatbuffers;
          spdlog = pkgs.spdlog;

          xplorer-flatbuffers = pkgs.xplorer-flatbuffers;
          liboorb = pkgs.liboorb;
          libooraf = pkgs.libooraf;
          libipc = pkgs.libipc;
        }
      );
      overlays.default = final: prev: {
        libzmq3-dev = prev.callPackage ./pkgs/libzmq3-dev { };
        argparse = prev.callPackage ./pkgs/argparse { };
        yaml-cpp = prev.callPackage ./pkgs/yaml-cpp { };
        googlebench = prev.callPackage ./pkgs/googlebench { };
        flatbuffers = prev.callPackage ./pkgs/flatbuffers { };
        spdlog = prev.callPackage ./pkgs/spdlog { };

        xplorer-flatbuffers = prev.callPackage ./pkgs/xplorer-flatbuffers { };
        liboorb = prev.callPackage ./pkgs/liboorb { };
        libooraf = prev.callPackage ./pkgs/libooraf { };
        libipc = prev.callPackage ./pkgs/libipc { };
      };
      # Devshell for bootstrapping
      # Acessible through 'nix develop' or 'nix-shell' (legacy)
      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./shell.nix { inherit pkgs; }
      );
    };
}
