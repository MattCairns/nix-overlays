{
  description = "Custom Nix Overlays for fun stuff";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "x86_64-linux"
      ];

    in
    {
      legacyPackages = forAllSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              self.overlays.default
            ];
          };
        in
        {
          libzmq3-dev = pkgs.libzmq3-dev;
          argparse = pkgs.argparse;
          yaml-cpp = pkgs.yaml-cpp;
          libamqp-cpp = pkgs.libamqp-cpp;
          flatbuffers-23-1-21 = pkgs.flatbuffers;
          spdlog = pkgs.spdlog;
          adi1090x-plymouth = pkgs.adi1090x-plymouth;
          aichat = pkgs.aichat;
          gptcommit = pkgs.gptcommit;
          hide-my-mess-rs = pkgs.hide-my-mess-rs;
          ktra = pkgs.ktra;
        }
      );
      overlays.default = final: prev: {
        libzmq3-dev = prev.callPackage ./pkgs/libzmq3-dev { };
        argparse = prev.callPackage ./pkgs/argparse { };
        yaml-cpp = prev.callPackage ./pkgs/yaml-cpp { };
        libamqp-cpp = prev.callPackage ./pkgs/amqp-cpp { };
        flatbuffers-23-1-21 = prev.callPackage ./pkgs/flatbuffers { };
        spdlog = prev.callPackage ./pkgs/spdlog { };
        adi1090x-plymouth = prev.callPackage ./pkgs/plymouth-themes { };
        aichat = prev.callPackage ./pkgs/aichat { };
        gptcommit = prev.callPackage ./pkgs/gptcommit { };
        hide-my-mess-rs = prev.callPackage ./pkgs/hide-my-mess-rs { };
        ktra = prev.callPackage ./pkgs/ktra { };
      };

      ktra-overlay = final: prev: {
        ktra = prev.callPackage ./pkgs/ktra { };
      };

      nixosModules = {
        ktra = import ./modules/ktra.nix;
      };
    };
}
