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
    rev = "2cdb6917ef5a573cf64022cc6c70f12ed9f5a1d2";
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
