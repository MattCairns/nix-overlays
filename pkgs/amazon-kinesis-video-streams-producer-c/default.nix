{
  stdenv,
  fetchFromGitHub,
  amazon-kinesis-video-streams-pic,
  libwebsockets,
  cmake,
  pkg-config,
  openssl,
  curl,
}:
stdenv.mkDerivation {
  name = "amazon-kinesis-video-streams-producer-c";

  src = fetchFromGitHub {
    owner = "awslabs";
    repo = "amazon-kinesis-video-streams-producer-c";
    rev = "v1.5.2";
    hash = "sha256-7ihP/wM1gK3rL+0itEmM8um/yTN5Vb9iOq4hzogVhfc=";
  };

  doCheck = true;

  nativeBuildInputs = [
    cmake
    pkg-config
    openssl
    curl
    amazon-kinesis-video-streams-pic
    libwebsockets
  ];

  postPatch = ''
    substituteInPlace libcproducer.pc.cmake \
      --replace '$'{exec_prefix}/@CMAKE_INSTALL_LIBDIR@ @CMAKE_INSTALL_FULL_LIBDIR@
    substituteInPlace libkvsCommonCurl.pc.cmake \
      --replace '$'{exec_prefix}/@CMAKE_INSTALL_LIBDIR@ @CMAKE_INSTALL_FULL_LIBDIR@
    substituteInPlace libkvsCommonLws.pc.cmake \
      --replace '$'{exec_prefix}/@CMAKE_INSTALL_LIBDIR@ @CMAKE_INSTALL_FULL_LIBDIR@
  '';

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DBUILD_DEPENDENCIES=False"
    "-DBUILD_COMMON_LWS=True"
    "-DBUILD_COMMON_CURL=False"
  ];
}
