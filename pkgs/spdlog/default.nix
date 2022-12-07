{ stdenv, cmake, pkg-config, gcc12 }:

stdenv.mkDerivation rec {
  name = "spdlog";

  src = builtins.fetchGit {
    url = "https://github.com/gabime/spdlog.git";
    ref = "master";   
  };

  buildInputs = [
    pkg-config cmake gcc12 
  ];

  doCheck = true;

  cmakeFlags = [
    "-DSPDLOG_BUILD_SHARED=ON"
    "-DSPDLOG_BUILD_STATIC=OFF"
    "-DSPDLOG_BUILD_EXAMPLE=OFF"
    "-DSPDLOG_BUILD_BENCH=OFF"
    "-DSPDLOG_BUILD_TESTS=OFF"
  ];

  nativeBuildInputs = [ cmake gcc12 ];


  postInstall = ''
    mkdir -p $out/share/doc/spdlog
    cp -rv ../example $out/share/doc/spdlog
  '';

}

