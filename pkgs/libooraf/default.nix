with import <nixpkgs> {
  overlays = [ (import ../default.nix) ]; 
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
    ref = "develop";   
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
