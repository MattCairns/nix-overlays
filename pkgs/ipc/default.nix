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
    rev = "ca2dc46fe7fab0aa7c36da39f01c88d0acd9341a";
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
