{ stdenv, cmake, libssh, openssl, pkg-config }:

stdenv.mkDerivation rec {
  name = "amqp-cpp";

  src = builtins.fetchGit {
    url = "git@gitlab.com:open-ocean-robotics/xplorer-vessel/3rd-party/amqp-cpp.git";
    ref = "OOR-master";   
    rev = "3ea3af992c6c55bac25056871b8d87c67a6f8a09";
  };

  nativeBuildInputs = [ cmake libssh openssl pkg-config ];

  doCheck = true;

  cmakeFlags = [
    "-DAMQP-CPP_BUILD_SHARED=ON"
    "-DAMQP-CPP_LINUX_TCP=ON"
    "-DCMAKE_BUILD_TYPE=Release"
  ];
}
