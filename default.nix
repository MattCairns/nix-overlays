{ pkgs, ... }:
{
  libzmq3-dev = pkgs.callPackage ./pkgs/libzmq3-dev { };
  argparse = pkgs.callPackage ./pkgs/argparse { };
  yaml-cpp = pkgs.callPackage ./pkgs/yaml-cpp { };
  googlebench = pkgs.callPackage ./pkgs/googlebench { };
  flatbuffers = pkgs.callPackage ./pkgs/flatbuffers { };
  spdlog = pkgs.callPackage ./pkgs/spdlog { };

  xplorer-flatbuffers = pkgs.callPackage ./pkgs/xplorer-flatbuffers { };
  liboorb = pkgs.callPackage ./pkgs/liboorb { };
  libooraf = pkgs.callPackage ./pkgs/libooraf { };
  libipc = pkgs.callPackage ./pkgs/libipc { };
}
