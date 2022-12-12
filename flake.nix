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
    xfbsPkg.url = "git+ssh://gitlab.com/open-ocean-robotics/xplorer-vessel/libs/xplorer-flatbuffers.git?ref=flake_update";
  };

  outputs = { self, nixpkgs, xfbsPkg, ... }@inputs:
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
      legacyPackages = forAllSystems (system:
        let
          xfbs = xfbsPkg.defaultPackage.${system};
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
          libamqp-cpp = pkgs.libamqp-cpp;
          googlebench = pkgs.googlebench;
          flatbuffers = pkgs.flatbuffers;
          spdlog = pkgs.spdlog;
          xplorer-flatbuffers = xfbs;

          liboorb = pkgs.liboorb;
          libooraf = pkgs.libooraf;
          libipc = pkgs.libipc;
          libsatcomms = pkgs.libsatcomms;
        }
      );
      overlays.default = final: prev: {
        libzmq3-dev = prev.callPackage ./pkgs/libzmq3-dev { };
        argparse = prev.callPackage ./pkgs/argparse { };
        yaml-cpp = prev.callPackage ./pkgs/yaml-cpp { };
        libamqp-cpp = prev.callPackage ./pkgs/amqp-cpp { };
        googlebench = prev.callPackage ./pkgs/googlebench { };
        flatbuffers = prev.callPackage ./pkgs/flatbuffers { };
        spdlog = prev.callPackage ./pkgs/spdlog { };

        /* xplorer-flatbuffers = prev.callPackage ./pkgs/xplorer-flatbuffers { }; */
        liboorb = prev.callPackage ./pkgs/liboorb { };
        libooraf = prev.callPackage ./pkgs/libooraf { };
        libipc = prev.callPackage ./pkgs/libipc { };
        libsatcomms = prev.callPackage ./pkgs/libsatcomms { };
      };
      # Devshell for bootstrapping
      # Acessible through 'nix develop' or 'nix-shell' (legacy)
      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./shell.nix { inherit pkgs; }
      );
    };
}
