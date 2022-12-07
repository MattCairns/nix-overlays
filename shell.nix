with import <nixpkgs> {
  overlays = [ (import ./default.nix) ]; 
};

mkShell {
  nativeBuildInputs = [ 
    libzmq3-dev 
    /* argparse */
    yaml-cpp
    googlebench 
    flatbuffers 
    spdlog 

    xplorer-flatbuffers 
    liboorb 
    ipc 
  ];
}
