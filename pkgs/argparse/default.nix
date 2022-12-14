{ stdenv, fetchurl, gcc12, cmake, pkg-config }:

stdenv.mkDerivation rec {
  name = "argparse";

  src = fetchurl {
    url = "https://github.com/p-ranav/argparse/archive/refs/tags/v2.9.tar.gz";
    sha256 = "sha256-zVYyk1gLncWSJU3zW0nPihm0hw/19hHHWEz5Z9nmAx4=";
  };

  postPatch = ''
    substituteInPlace CMakeLists.txt \
      --replace '$'{CMAKE_INSTALL_LIBDIR_ARCHIND} '$'{CMAKE_INSTALL_LIBDIR}
    substituteInPlace packaging/pkgconfig.pc.in \
      --replace '$'{prefix}/@CMAKE_INSTALL_INCLUDEDIR@ @CMAKE_INSTALL_FULL_INCLUDEDIR@
  '';

  nativeBuildInputs = [ gcc12 cmake pkg-config ];

  doCheck = true;

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];
}
