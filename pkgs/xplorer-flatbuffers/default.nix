{ stdenv, cmake, pkg-config, flatbuffers }:

stdenv.mkDerivation rec {
  name = "xplorer-flatbuffers";

  src = builtins.fetchGit {
    url = "git@gitlab.com:open-ocean-robotics/xplorer-vessel/libs/xplorer-flatbuffers.git";
    ref = "add_pkgconfig";   
    rev = "dc02e0e85c1a36187b3316d320b661d5e0634524";
  };

  nativeBuildInputs = [ cmake flatbuffers pkg-config ];

  doCheck = true;

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];

}
