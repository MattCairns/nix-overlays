with import <nixpkgs> {
  overlays = [ (import ../../default.nix) ]; 
};

{ stdenv, cmake, flatbuffers, spdlog, pkg-config, xplorer-flatbuffers, nlohmann_json }:

stdenv.mkDerivation rec {
  name = "liboorb";

  src = builtins.fetchGit {
    url = "git@gitlab.com:open-ocean-robotics/xplorer-vessel/libs/liboorb-common-utils.git";
    ref = "fix_nlohmann";   
    rev = "a907a0358423de54ad0095f5200648a1ca3505d3";
  };

  nativeBuildInputs = [ cmake spdlog flatbuffers pkg-config xplorer-flatbuffers nlohmann_json ];

  doCheck = true;

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];
}
