with import <nixpkgs> {
  overlays = [ (import ./default.nix) ]; 
};

mkShell {
  nativeBuildInputs = [ flatbuffers xplorer-flatbuffers spdlog googlebench oorb libzmq3-dev ipc ];
}
