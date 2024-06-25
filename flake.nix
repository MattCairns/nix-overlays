{
  description = "Custom Nix Overlays for fun stuff";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "x86_64-linux"
    ];
  in rec {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
    legacyPackages = forAllSystems (
      system: let
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
        flatbuffers-23-1-21 = pkgs.flatbuffers;
        spdlog = pkgs.spdlog;
        adi1090x-plymouth = pkgs.adi1090x-plymouth;
        tailscale = pkgs.tailscale;
        aichat = pkgs.aichat;
        gptcommit = pkgs.gptcommit;
        hide-my-mess-rs = pkgs.hide-my-mess-rs;
        molecule = pkgs.molecule;
        molecule-plugins = pkgs.molecule-plugins;
      }
    );
    overlays.default = final: prev: {
      libzmq3-dev = prev.callPackage ./pkgs/libzmq3-dev {};
      argparse = prev.callPackage ./pkgs/argparse {};
      yaml-cpp = prev.callPackage ./pkgs/yaml-cpp {};
      libamqp-cpp = prev.callPackage ./pkgs/amqp-cpp {};
      googlebench = prev.callPackage ./pkgs/googlebench {};
      flatbuffers-23-1-21 = prev.callPackage ./pkgs/flatbuffers {};
      spdlog = prev.callPackage ./pkgs/spdlog {};
      adi1090x-plymouth = prev.callPackage ./pkgs/plymouth-themes {};
      tailscale = prev.callPackage ./pkgs/tailscale {};
      aichat = prev.callPackage ./pkgs/aichat {};
      gptcommit = prev.callPackage ./pkgs/gptcommit {};
      hide-my-mess-rs = prev.callPackage ./pkgs/hide-my-mess-rs {};
      molecule = prev.callPackage ./pkgs/molecule {};
      molecule-plugins = prev.callPackage ./pkgs/molecule-plugins {};
    };
  };
}
