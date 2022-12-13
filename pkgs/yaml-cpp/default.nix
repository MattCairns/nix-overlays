{ stdenv, gcc12, cmake, pkg-config }:

stdenv.mkDerivation rec {
  name = "argparse";

  src = builtins.fetchGit {
    url = "git@gitlab.com:open-ocean-robotics/xplorer-vessel/3rd-party/oor-yaml-cpp.git";
    ref = "master-oor";   
    rev = "744970e25f359e02be70e402069f6f7c177a58de";
  };

  nativeBuildInputs = [ gcc12 cmake pkg-config ];

  doCheck = true;

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];
}
