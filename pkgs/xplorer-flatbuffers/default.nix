{ stdenv, cmake, pkg-config, flatbuffers }:

stdenv.mkDerivation rec {
  name = "xplorer-flatbuffers";

  src = builtins.fetchGit {
    url = "git@gitlab.com:open-ocean-robotics/xplorer-vessel/libs/xplorer-flatbuffers.git";
    ref = "OOR-2735-resolve-pkgconfig-and-file-include-pathing-issues";   
    rev = "6938a775a5b6ede62dd9f84831d44976b65daa02";
  };

  nativeBuildInputs = [ cmake flatbuffers pkg-config ];

  doCheck = true;

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];

}
