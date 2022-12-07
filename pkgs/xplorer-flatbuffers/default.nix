{ stdenv, cmake, pkg-config, flatbuffers }:

stdenv.mkDerivation rec {
  name = "xplorer-flatbuffers";

  src = builtins.fetchGit {
    url = "git@gitlab.com:open-ocean-robotics/xplorer-vessel/libs/xplorer-flatbuffers.git";
    ref = "add_pkgconfig";   
    rev = "7cf716ddc10c813c1b4c3cd0a4f20e4346819e93";
  };

  nativeBuildInputs = [ cmake flatbuffers pkg-config ];

  doCheck = true;

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];

}
