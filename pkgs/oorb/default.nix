with import <nixpkgs> {
  overlays = [ (import ../../default.nix) ]; 
};

{ stdenv, cmake, flatbuffers, spdlog, pkg-config, xplorer-flatbuffers, nlohmann_json }:

stdenv.mkDerivation rec {
  name = "liboorb";

  src = builtins.fetchGit {
    url = "git@gitlab.com:open-ocean-robotics/xplorer-vessel/libs/liboorb-common-utils.git";
    ref = "fix_nlohmann";   
    rev = "8e528cb7b5a309257dbba1a2429c8ad1711a8c80";
  };

  nativeBuildInputs = [ cmake spdlog flatbuffers pkg-config xplorer-flatbuffers nlohmann_json ];

  doCheck = true;

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];
}
