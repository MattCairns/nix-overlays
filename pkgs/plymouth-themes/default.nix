{
  stdenv,
  fetchurl,
  git,
}:
stdenv.mkDerivation rec {
  pname = "adi1090x-plymouth";
  version = "0.0.1";

  src = fetchurl {
    url = "https://github.com/adi1090x/plymouth-themes/archive/refs/heads/master.tar.gz";
    sha256 = "sha256-fhCRLMVZR2bq5k6n7Of4u6up6+lS55m3hj1WHaE9cCs=";
  };

  buildInputs = [
    git
  ];

  configurePhase = ''
    mkdir -p $out/share/plymouth/themes/
  '';

  buildPhase = ''
  '';

  installPhase = ''
    cp -r pack_3/lone $out/share/plymouth/themes
    cat pack_3/lone/lone.plymouth | sed  "s@\/usr\/@$out\/@" > $out/share/plymouth/themes/lone/lone.plymouth
  '';
}
