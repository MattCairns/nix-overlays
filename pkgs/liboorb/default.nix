with import <nixpkgs> {
  overlays = [ (import ../../default.nix) ]; 
};

{ 
  stdenv,
  cmake,
  flatbuffers,
  spdlog,
  pkg-config,
  xplorer-flatbuffers,
  nlohmann_json
}:

stdenv.mkDerivation rec {
  name = "liboorb";

  src = builtins.fetchGit {
    url = "git@gitlab.com:open-ocean-robotics/xplorer-vessel/libs/liboorb-common-utils.git";
    ref = "OOR-2735-resolve-pkgconfig-and-file-include-pathing-issues";   
    rev = "daf6315813258a4e93703fef8669eec62cf463ae";
  };

  nativeBuildInputs = [ 
    cmake
    spdlog
    flatbuffers
    pkg-config
    xplorer-flatbuffers
    nlohmann_json
  ];

  doCheck = true;

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];
}
