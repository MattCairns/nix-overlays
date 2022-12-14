{ stdenv, fetchurl, cmake, libssh, openssl, pkg-config }:

stdenv.mkDerivation rec {
  name = "amqp-cpp";

  src = fetchurl {
    url = "https://github.com/CopernicaMarketingSoftware/AMQP-CPP/archive/refs/tags/v4.3.18.tar.gz";
    sha256 = "sha256-zCwfxdoAoXeMKAQwbga97ceCpfdHYrnZtELTpJjdDE8=";
  };

  nativeBuildInputs = [ cmake libssh openssl pkg-config ];

  doCheck = true;

  cmakeFlags = [
    "-DAMQP-CPP_BUILD_SHARED=ON"
    "-DAMQP-CPP_LINUX_TCP=ON"
    "-DCMAKE_BUILD_TYPE=Release"
  ];
}
