self: super:
{
  googlebench = super.callPackage ./pkgs/googlebench { };
  flatbuffers = super.callPackage ./pkgs/flatbuffers { };
  spdlog = super.callPackage ./pkgs/spdlog { };
  xplorer-flatbuffers = super.callPackage ./pkgs/xplorer-flatbuffers { };
  oorb = super.callPackage ./pkgs/oorb { };
  /* pantable = super.callPackage ./pkgs/pantable { };
  cxxopts = super.callPackage ./pkgs/cxxopts { };
  pegtl = super.callPackage ./pkgs/pegtl { };
  netron = super.callPackage ./pkgs/netron { }; */
}
