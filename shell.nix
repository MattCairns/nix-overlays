with import <nixpkgs> {
  overlays = [ (import ./default.nix) ]; 
};

mkShell {
  nativeBuildInputs = [ 
    /* flatbuffers  */
    /* xplorer-flatbuffers  */
    /* spdlog  */
    /* googlebench  */
    liboorb 
    /* libzmq3-dev  */
    /* ipc  */
  ];
}
