with import <nixpkgs> {
  overlays = [ (import ../../default.nix) ]; 
};

{ stdenv, fetchurl, cmake, pkg-config }:

stdenv.mkDerivation rec {
  name = "libzmq3-dev";

  src = fetchurl {
    url = "https://github.com/zeromq/libzmq/releases/download/v4.3.4/zeromq-4.3.4.tar.gz";
    sha256 = "sha256-xZMAGon1qF3S3fVkgF3rhg4CRxFxs/IElEhXM2KVw+U=";
  };

  nativeBuildInputs = [ cmake pkg-config ];

  doCheck = true;

  /* cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ]; */
}
