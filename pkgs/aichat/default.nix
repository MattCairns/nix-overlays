{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "aichat";
  version = "v0.8.0";

  src = fetchFromGitHub {
    owner = "sigoden";
    repo = pname;
    rev = version;
    hash = "sha256-E/QslRDeifFHlHUELv9rYHjfCAB1yXXiXlWOyPNkfps=";
  };

  cargoHash = "sha256-i0HAIOZHw/WDmWV4DZcrbzkbptbLxzEw/xFEwuE65Cg=";
}
