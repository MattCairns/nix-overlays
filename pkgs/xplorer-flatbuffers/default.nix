/* with import <nixpkgs> {
  overlays = [ (import ../default.nix) ]; 
}; */
{ stdenv, cmake, pkg-config, flatbuffers, system}:

stdenv.mkDerivation rec {
  name = "xplorer-flatbuffers";

  src = builtins.fetchGit {
    url = "git@gitlab.com:open-ocean-robotics/xplorer-vessel/libs/xplorer-flatbuffers.git";
    ref = "develop";   
  };

  nativeBuildInputs = [ cmake flatbuffers pkg-config ];

  doCheck = true;

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];

}
