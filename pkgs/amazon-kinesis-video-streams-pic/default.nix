{
  stdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  sd
}:
stdenv.mkDerivation {
  name = "amazon-kinesis-video-streams-pic";

   src = fetchFromGitHub {
    owner = "awslabs";
    repo = "amazon-kinesis-video-streams-pic";
    rev = "v1.1.0";
    hash = "sha256-aDI27gB6SDa4bib8dIMpUS1wHNX5g70CamM3LbAhACQ=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  doCheck = true;

  postPatch = ''
    substituteInPlace libkvspic.pc.cmake \
      --replace '$'{exec_prefix}/@CMAKE_INSTALL_LIBDIR@ @CMAKE_INSTALL_FULL_LIBDIR@
    substituteInPlace libkvspicClient.pc.cmake \
      --replace '$'{exec_prefix}/@CMAKE_INSTALL_LIBDIR@ @CMAKE_INSTALL_FULL_LIBDIR@
    substituteInPlace libkvspicState.pc.cmake \
      --replace '$'{exec_prefix}/@CMAKE_INSTALL_LIBDIR@ @CMAKE_INSTALL_FULL_LIBDIR@
    substituteInPlace libkvspicUtils.pc.cmake \
      --replace '$'{exec_prefix}/@CMAKE_INSTALL_LIBDIR@ @CMAKE_INSTALL_FULL_LIBDIR@
  '';

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DBUILD_TEST=FALSE"
    "-DBUILD_DEPENDENCIES=FALSE"
  ];

  # installPhase =  ''
  #   ${sd}/bin/sd --string-mode '$${"{prefix}//nix/store"}' '/nix/store' **/*.pc
  #   make install DESTDIR=$out
  # '';
}
