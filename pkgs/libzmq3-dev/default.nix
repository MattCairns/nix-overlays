{ stdenv, fetchurl, cmake, pkg-config, libsodium }:

stdenv.mkDerivation rec {
  name = "libzmq3-dev";

  src = fetchurl {
    url = "https://github.com/zeromq/libzmq/releases/download/v4.3.4/zeromq-4.3.4.tar.gz";
    sha256 = "sha256-xZMAGon1qF3S3fVkgF3rhg4CRxFxs/IElEhXM2KVw+U=";
  };

  nativeBuildInputs = [ cmake pkg-config libsodium ];

  doCheck = true;

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DWITH_PERF_TOOL=OFF" 
    "-DZMQ_BUILD_TESTS=OFF"
    "-DENABLE_CPACK=OFF" 
  ];
}
