{
  stdenv,
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
}: let
  pname = "gptcommit";
  version = "0.5.5";
in
  rustPlatform.buildRustPackage {
    inherit pname version;

    src = fetchFromGitHub {
      owner = "zurawiki";
      repo = pname;
      rev = "v${version}";
      sha256 = "sha256-2Fe1IDD/FwP61pjrI9UhEUnamzza8e2+ZVPqP3K3bHs=";
    };

    cargoSha256 = "sha256-TgSpEsUQDgzGanKtPUutns2GsPe9KhWiSDhTOEO3hg8=";

    doCheck = false;

    nativeBuildInputs = [pkg-config];
  }
