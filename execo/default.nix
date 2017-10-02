{ stdenv, fetchFromGitHub, pythonPackages, pkgs}:

pythonPackages.buildPythonPackage rec {
  name = "execo-2.6.1";
  src = pkgs.fetchurl {
    url = "mirror://pypi/e/execo/${name}.tar.gz";
    sha256 = "1kffz1lyqq41gfvfq0n9j4g7anw07py9slicsydnzq50n3pl5089";
  };

  checkPhase = ''
    python -c "import execo"
  '';
  doCheck = true;

  # Use this patch to enable cwd options for Process and make the engin
  # parameters override works
  patches = [ ./add_cwd_attribute_2.6.1.post0.patch ];

  meta = with stdenv.lib; {
    description = "Python library that allows you to finely manage unix processes on thousands of remote hosts ";
    homepage    = http://execo.gforge.inria.fr/doc/latest-stable/execo.html;
    platforms   = platforms.unix;
    licence     = licenses.gpl3Plus;
    longDescription = ''
      Execo offers a Python API for asynchronous control of local or remote,
      standalone or parallel, unix processes. It is especially well suited
      for quickly and easily scripting workflows of parallel/distributed
      operations on local or remote hosts: automate a scientific workflow,
      conduct computer science experiments, perform automated tests, etc.
      The core python package is execo. The execo_g5k package provides a
      set of tools and extensions for the Grid5000 testbed. The
      execo_engine package provides tools to ease the development of
      computer sciences experiments.
    '';
  };
}
