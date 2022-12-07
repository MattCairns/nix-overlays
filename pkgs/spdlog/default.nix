{ stdenv, cmake, pkg-config, gcc12 }:

stdenv.mkDerivation rec {
  name = "spdlog";

  src = builtins.fetchGit {
    url = "git@gitlab.com:open-ocean-robotics/xplorer-vessel/3rd-party/oor-spdlog.git";
    ref = "master-oor";   
    rev = "e96105e99f570b2fd30fdc185c5b0efeb243c86f";
  };

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

