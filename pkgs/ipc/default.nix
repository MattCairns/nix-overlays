with import <nixpkgs> {
  overlays = [ (import ../../default.nix) ]; 
};

{ stdenv, cmake, flatbuffers, spdlog, pkg-config, xplorer-flatbuffers, oorb, libzmq3-dev }:

stdenv.mkDerivation rec {
  name = "ipc";

  src = builtins.fetchGit {
    url = "git@gitlab.com:open-ocean-robotics/xplorer-vessel/core/ipc.git";
    ref = "develop";   
  };

  nativeBuildInputs = [ cmake spdlog flatbuffers pkg-config xplorer-flatbuffers oorb libzmq3-dev ];

  doCheck = true;

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];
}
