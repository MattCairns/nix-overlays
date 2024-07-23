{
  stdenv,
  cmake,
  pkg-config,
  flatbuffers-23-1-21,
}:
stdenv.mkDerivation {
  name = "xplorer-flatbuffers";

  src = builtins.fetchGit {
    url = "ssh://git@gitlab.com/open-ocean-robotics/xplorer-vessel/libs/xplorer-flatbuffers.git";
    rev = "f7f752d2861f775eae4a97c0c4e12ed6cb4060a9";
    ref = "develop";
  };

  nativeBuildInputs = [cmake pkg-config flatbuffers-23-1-21];

  doCheck = true;

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];
}
