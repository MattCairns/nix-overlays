{ stdenv, fetchurl, cmake, git }:

stdenv.mkDerivation rec {
  name = "flatbuffers";

  src = fetchurl {
    url = "https://github.com/google/flatbuffers/archive/refs/tags/v2.0.0.tar.gz";
    sha256 = "sha256-nduQMXmPT4dU0A/KLxpo7PnQ+D36xyOa8TEeT9mlZcQ=";
  };

  buildInputs = [ cmake git ];

  doCheck = true;

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"

  ];

  nativeBuildInputs = [ cmake ];
}
