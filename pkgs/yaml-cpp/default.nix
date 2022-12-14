{ stdenv, fetchurl, gcc12, cmake, pkg-config }:

stdenv.mkDerivation rec {
  name = "argparse";

  src = fetchurl {
    url = "https://github.com/jbeder/yaml-cpp/archive/refs/heads/master.tar.gz";
    sha256 = "sha256-lDWDPZyfKdztVpNviGLN7iyVW15PaL1pNTAuu0u3ZVs=";
  };

  nativeBuildInputs = [ gcc12 cmake pkg-config ];

  doCheck = true;

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];
}
