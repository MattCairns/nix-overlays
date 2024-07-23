{
  lib,
  pkgs,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "hide-my-mess-rs";
  version = "v0.1.1";

  src = fetchFromGitHub {
    owner = "OtaK";
    repo = pname;
    rev = version;
    hash = "sha256-/KCXgMhsQum1WuNQhDiY+XP7XSZRkadq8V3gaalgZV4=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "nokhwa-0.10.0" = "sha256-3pWdN1l1zfSG//3EZEppYbq8P20oqCgxWOOui1OrtcA=";
    };
  };

  LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
  nativeBuildInputs = [
    pkgs.llvmPackages_15.clangUseLLVM
    pkgs.libclang
    pkgs.pkg-config
  ];

  buildInputs = [
    pkgs.libtensorflow
    pkgs.openssl
  ];

  doCheck = false;

  cargoHash = "sha256-i0HAIOZHw/WDmWV4DZcrbzkbptbLxzEw/xFEwuE65Cg=";
}
