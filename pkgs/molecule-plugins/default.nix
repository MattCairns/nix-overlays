{
  python310,
  python310Packages,
  molecule,
  selinux-python,
}:
python310.pkgs.buildPythonPackage rec {
  pname = "molecule-plugins";
  version = "23.4.1";
  format = "pyproject";

  src = python310.pkgs.fetchPypi {
    inherit pname version;
    sha256 = "sha256-NMR+4sEcNbowyoTqaEwe4Wac9+WNIZesnb/L9C0KG3s=";
  };

  doCheck = false;

  propagatedBuildInputs = [
    python310Packages.docker
    selinux-python
  ];

  buildInputs = [
    python310Packages.setuptools
    python310Packages.setuptools-scm
    python310Packages.setuptools-scm-git-archive
    python310Packages.wheel
    molecule
  ];
}
