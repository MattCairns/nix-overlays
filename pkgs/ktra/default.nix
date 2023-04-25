{ lib, pkgs, fetchFromGitHub, rustPlatform }:
rustPlatform.buildRustPackage rec {
  pname = "ktra";
  version = "0.5.1";

  src = fetchFromGitHub {
    owner = "jean-airoldie";
    repo = pname;
    rev = version;
    hash = "sha256-IivR7KP2nULH/ucM5nSk9/AsQCJTu1+j+JjDfV36xUo=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
  };

  postPatch = ''
    cp ${./Cargo.lock} Cargo.lock
  '';

  nativeBuildInputs = [
    pkgs.pkg-config
  ];

  buildInputs = [
    pkgs.openssl
  ];

  doCheck = false;

  cargoHash = lib.fakeHash;
}
