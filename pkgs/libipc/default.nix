with import <nixpkgs> {
  overlays = [ (import ../default.nix) ]; 
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
  name = "libipc";

  src = builtins.fetchGit {
    url = "git@gitlab.com:open-ocean-robotics/xplorer-vessel/core/ipc.git";
    ref = "develop";   
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
