{
  stdenv,
  fetchFromGitHub,
  cmake,
  git,
}:
stdenv.mkDerivation rec {
  pname = "flatbuffers";
  version = "23.1.21";

  src = fetchFromGitHub {
    owner = "google";
    repo = "${pname}";
    rev = "v${version}";
    sha256 = "/46Yo186PjewYN+e/UWZc0QQhXZcq/x7iaN48RA1avw=";
  };

  buildInputs = [cmake git];

  doCheck = true;

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];

  nativeBuildInputs = [cmake];
}
