with import <nixpkgs> {
  overlays = [ (import ../../default.nix) ]; 
};

{ stdenv, cmake, flatbuffers, spdlog, pkg-config, xplorer-flatbuffers, argparse, libyamlcpp }:

stdenv.mkDerivation rec {
  name = "ooraf";

  src = builtins.fetchGit {
    url = "git@gitlab.com:open-ocean-robotics/xplorer-vessel/libs/ooraf.git";
    ref = "develop";   
  };

  nativeBuildInputs = [ cmake spdlog flatbuffers pkg-config xplorer-flatbuffers argparse libyamlcpp ];

  doCheck = true;

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];
}
