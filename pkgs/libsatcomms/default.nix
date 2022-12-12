/* with import <nixpkgs> {
  overlays = [ (import ../default.nix) ]; 
};
 */
{ 
  stdenv,
  gcc11,
  cmake,
  pkg-config,
  xplorer-flatbuffers,
  liboorb
}:

stdenv.mkDerivation rec {
  name = "libsatcomms";

  src = builtins.fetchGit {
    url = "git@gitlab.com:open-ocean-robotics/xplorer-vessel/libs/libsatcomms.git";
    ref = "master";   
  };

  nativeBuildInputs = [ 
    cmake
    gcc11
    pkg-config
    xplorer-flatbuffers
    liboorb
  ];

  doCheck = true;

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];
}
