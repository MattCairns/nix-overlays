{ stdenv, cmake, git }:

stdenv.mkDerivation rec {
  name = "flatbuffers";

  src = builtins.fetchGit {
    url = "https://github.com/google/flatbuffers.git";
    ref = "refs/tags/v2.0.0";   
  };

  buildInputs = [ cmake git ];

  doCheck = true;

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"

  ];

  nativeBuildInputs = [ cmake ];

  /* buildPhase = "cmake . && make -j"; */

  /* postInstall = ''
    mkdir -p $out/share/doc/spdlog
    cp -rv ../example $out/share/doc/spdlog
  ''; */

}
