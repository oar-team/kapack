{ stdenv, fetchFromGitHub, python35Packages, pkgs}:

python35Packages.buildPythonPackage rec {
  name = "execo-2.6.1";
  src = pkgs.fetchurl {
    url = "https://pypi.python.org/packages/4a/b8/d801111afdbb5e32ce05ce0553e5ebb1a8174e2c00808b8efdbfa55f7d30/execo-2.6.1.tar.gz";
    sha256 = "098142efb0a0e06f9bd72c529dfc3d805b751e91c902ecb67b8160ec69f8cecd";
  };

  doCheck=false;

  patches = [ ./2.6.1.post0.patch ];

  meta = with stdenv.lib; {
    description = "Python library that allows you to finely manage unix processes on thousands of remote hosts ";
    homepage    = http://execo.gforge.inria.fr/doc/latest-stable/execo.html;
    platforms   = platforms.unix;
    licence = licences.gpl3Plus;
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
