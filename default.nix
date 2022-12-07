self: super:
{
  libzmq3-dev = super.callPackage ./pkgs/libzmq3-dev { };
  argparse = super.callPackage ./pkgs/argparse { };
  yaml-cpp = super.callPackage ./pkgs/yaml-cpp { };
  googlebench = super.callPackage ./pkgs/googlebench { };
  flatbuffers = super.callPackage ./pkgs/flatbuffers { };
  spdlog = super.callPackage ./pkgs/spdlog { };

  xplorer-flatbuffers = super.callPackage ./pkgs/xplorer-flatbuffers { };
  liboorb = super.callPackage ./pkgs/liboorb { };
  libooraf = super.callPackage ./pkgs/libooraf { };
  libipc = super.callPackage ./pkgs/libipc { };
}
