{ stdenv, cmake, git }:

stdenv.mkDerivation rec {
  name = "flatbuffers";

  src = builtins.fetchGit {
    url = "https://github.com/google/flatbuffers.git";
    ref = "refs/tags/v2.0.0";   
    rev = "a9a295fecf3fbd5a4f571f53b01f63202a3e2113";
  };

  buildInputs = [ cmake git ];

  doCheck = true;

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"

  ];

  nativeBuildInputs = [ cmake ];
}
