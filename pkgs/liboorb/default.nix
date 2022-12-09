/* with import <nixpkgs> {
  overlays = [ (import ../default.nix) ]; 
};
 */
{ 
  stdenv,
  cmake,
  flatbuffers,
  spdlog,
  pkg-config,
  nlohmann_json,
  xplorer-flatbuffers,
}:

stdenv.mkDerivation rec {
  name = "liboorb";

  src = builtins.fetchGit {
    url = "git@gitlab.com:open-ocean-robotics/xplorer-vessel/libs/liboorb-common-utils.git";
    ref = "OOR-2735-resolve-pkgconfig-and-file-include-pathing-issues";   
    rev = "e0216b89ed3fca6dddefa3c4ae474197fc5fc9aa";
  };

  nativeBuildInputs = [ 
    cmake
    spdlog
    flatbuffers
    pkg-config
    xplorer-flatbuffers
    nlohmann_json
  ];

  doCheck = true;

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];
}
