{ stdenv, cmake, libssh, openssl, pkg-config }:

stdenv.mkDerivation rec {
  name = "amqp-cpp";

  src = builtins.fetchGit {
    url = "git@gitlab.com:open-ocean-robotics/xplorer-vessel/3rd-party/amqp-cpp.git";
    ref = "OOR-master";   
  };

  nativeBuildInputs = [ cmake libssh openssl pkg-config ];

  doCheck = true;

  cmakeFlags = [
    "-DAMQP-CPP_BUILD_SHARED=ON"
    "-DAMQP-CPP_LINUX_TCP=ON"
    "-DCMAKE_BUILD_TYPE=Release"
  ];
}
