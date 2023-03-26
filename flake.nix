{
  description = "Custom Nix Overlays for fun stuff";

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
          libamqp-cpp = pkgs.libamqp-cpp;
          googlebench = pkgs.googlebench;
          flatbuffers = pkgs.flatbuffers;
          spdlog = pkgs.spdlog;
          adi1090x-plymouth = pkgs.adi1090x-plymouth;
          tailscale = pkgs.tailscale;
          aichat = pkgs.aichat;
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
        adi1090x-plymouth = prev.callPackage ./pkgs/plymouth-themes { };
        tailscale = prev.callPackage ./pkgs/tailscale { };
        aichat = prev.callPackage ./pkgs/aichat { };
      };
    };
}
