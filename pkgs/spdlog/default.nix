{ stdenv, cmake, fetchurl, fetchpatch, pkg-config, gcc12 }:

stdenv.mkDerivation rec {
  name = "spdlog";

  src = fetchurl {
    url = "https://github.com/gabime/spdlog/archive/refs/tags/v1.9.2.tar.gz";
    sha256 = "sha256-b/+SFfXLgXYL5MwW0DNSbRCAQn0jbobXC7AplPhePTg=";
  };

  patches = [
    (fetchpatch {
      name = "Allow absolute CMAKE_INSTALL_LIBDIR";
      url = "https://github.com/gabime/spdlog/commit/afb69071d5346b84e38fbcb0c8c32eddfef02a55.patch";
      sha256 = "sha256-2MwNpXEo8GJvVaoKDQumrTlxi+POs+1ghs5/tNcSSzE=";
    })
  ];
   

  buildInputs = [
    pkg-config cmake gcc12 
  ];

  doCheck = true;

  cmakeFlags = [
    "-DSPDLOG_BUILD_SHARED=ON"
  ];

  nativeBuildInputs = [ cmake gcc12 ];

  postInstall = ''
    mkdir -p $out/share/doc/spdlog
    cp -rv ../example $out/share/doc/spdlog
  '';
}

