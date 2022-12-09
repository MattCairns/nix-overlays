# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'

{ pkgs ? (import <nixpkgs> {}).pkgs }: {
  libzmq3-dev = pkgs.callPackage ./libzmq3-dev { };
  argparse = pkgs.callPackage ./argparse { };
  yaml-cpp = pkgs.callPackage ./yaml-cpp { };
  googlebench = pkgs.callPackage ./googlebench { };
  flatbuffers = pkgs.callPackage ./flatbuffers { };
  spdlog = pkgs.callPackage ./spdlog { };

  xplorer-flatbuffers = pkgs.callPackage ./xplorer-flatbuffers { };
  liboorb = pkgs.callPackage ./liboorb { };
  libooraf = pkgs.callPackage ./libooraf { };
  libipc = pkgs.callPackage ./libipc { };
}
