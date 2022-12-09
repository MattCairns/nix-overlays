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
      # Your custom packages
      # Acessible through 'nix build', 'nix shell', etc
      packages = forAllSystems (system:
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
