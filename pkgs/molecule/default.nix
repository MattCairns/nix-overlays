{
  python310,
  python310Packages,
}:
python310.pkgs.buildPythonPackage rec {
  pname = "molecule";
  version = "5.0.0";
  format = "pyproject";

  src = python310Packages.fetchPypi {
    inherit pname version;
    sha256 = "sha256-YjgCPZC1wzknFGhoSXdvQqBJ2fPkQHXTbq2fj/iMJg0=";
  };

  doCheck = false;

  propagatedBuildInputs = [
    python310Packages.ansible-core
    python310Packages.ansible-compat
    python310Packages.click-help-colors
    python310Packages.cookiecutter
    python310Packages.enrich
    python310Packages.jsonschema
    python310Packages.packaging
    python310Packages.pluggy
    python310Packages.pyyaml
  ];

  buildInputs = [
    python310Packages.setuptools
    python310Packages.setuptools-scm
    python310Packages.setuptools-scm-git-archive
    python310Packages.wheel
  ];
}
