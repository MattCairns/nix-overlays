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
    ref = "fix_nlohmann";   
    rev = "5e7f0deee9e83293c0254c14cb77c710687f32e7";
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
