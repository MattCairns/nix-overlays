with import <nixpkgs> {
  overlays = [ (import ../default.nix) ]; 
};

{ stdenv, cmake, pkg-config }:

stdenv.mkDerivation rec {
  name = "argparse";

  src = builtins.fetchGit {
    url = "git@gitlab.com:open-ocean-robotics/xplorer-vessel/3rd-party/oor-yaml-cpp.git";
    ref = "master-oor";   
  };

  nativeBuildInputs = [ cmake pkg-config ];

  doCheck = true;

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];
}
