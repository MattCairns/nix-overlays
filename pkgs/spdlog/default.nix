{ gcc10Stdenv, cmake, fetchFromGitHub, fetchpatch, pkg-config, gcc12 }:

gcc10Stdenv.mkDerivation rec {
  name = "spdlog";
  version = "1.9.2";

  src = fetchFromGitHub {
    owner = "gabime";
    repo = "spdlog";
    rev = "v${version}";
    sha256 = "sha256-GSUdHtvV/97RyDKy8i+ticnSlQCubGGWHg4Oo+YAr8Y=";
  };

  patches = [
    (fetchpatch {
      name = "Allow absolute CMAKE_INSTALL_LIBDIR";
      url = "https://github.com/gabime/spdlog/commit/afb69071d5346b84e38fbcb0c8c32eddfef02a55.patch";
      sha256 = "sha256-2MwNpXEo8GJvVaoKDQumrTlxi+POs+1ghs5/tNcSSzE=";
    })
  ];


  buildInputs = [
    pkg-config
    cmake
  ];

  doCheck = true;

  cmakeFlags = [
    "-DSPDLOG_BUILD_SHARED=ON"
  ];

  nativeBuildInputs = [ cmake ];

  postInstall = ''
    mkdir -p $out/share/doc/spdlog
    cp -rv ../example $out/share/doc/spdlog
  '';
}
