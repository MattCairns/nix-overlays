with import <nixpkgs> {
  overlays = [ (import ./default.nix) ]; 
};

mkShell {
  nativeBuildInputs = [ flatbuffers xplorer-flatbuffers spdlog googlebenchz oorb ];
}
