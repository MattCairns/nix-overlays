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
  liboorb,
  nlohmann_json,
  libzmq3-dev,
  libsodium,
  gcc12
}:

stdenv.mkDerivation rec {
  name = "ipc";

  src = builtins.fetchGit {
    url = "git@gitlab.com:open-ocean-robotics/xplorer-vessel/core/ipc.git";
    ref = "path_fixes";   
    rev = "fee9a26971ac452fbe723dc47a727583aed875cb";
  };

  nativeBuildInputs = [ 
    cmake 
    spdlog 
    flatbuffers 
    pkg-config 
    xplorer-flatbuffers 
    liboorb 
    nlohmann_json
    libzmq3-dev 
    libsodium
    gcc12
  ];

  doCheck = true;

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];
}
