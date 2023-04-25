{ lib, pkgs, fetchFromGitHub, rustPlatform }:
rustPlatform.buildRustPackage rec {
  pname = "ktra";
  version = "0.7.0";

  src = fetchFromGitHub {
    owner = "moriturus";
    repo = pname;
    rev = version;
    hash = "sha256-mrPR9BJMdG22z56QgGB9imZIel5E21AggqmHXWQ7YVQ=";
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
