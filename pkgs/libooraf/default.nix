with import <nixpkgs> {
  overlays = [ (import ../../default.nix) ]; 
};

{ 
  stdenv,
  cmake,
  gcc12,
  flatbuffers,
  spdlog,
  pkg-config,
  argparse,
  libyamlcpp,
  libzmq3-dev,
  liboorb,
  libipc,
  xplorer-flatbuffers,
}:

stdenv.mkDerivation rec {
  name = "libooraf";

  src = builtins.fetchGit {
    url = "git@gitlab.com:open-ocean-robotics/xplorer-vessel/libs/ooraf.git";
    ref = "OOR-2735-resolve-pkgconfig-and-file-include-pathing-issues";   
    rev = "e29080278bbe967360a725541e1393f48d8a57fa";
  };

  nativeBuildInputs = [ 
    cmake
    gcc12
    spdlog
    flatbuffers
    pkg-config
    argparse
    libyamlcpp
    libzmq3-dev
    liboorb
    libipc
    xplorer-flatbuffers
  ];

  doCheck = true;

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];
}
