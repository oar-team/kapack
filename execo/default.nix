{ stdenv, fetchFromGitHub, python35Packages}:

python35Packages.buildPythonPackage rec {
  name = "execo-git";

  src = fetchFromGitHub {
    owner = "mickours";
    repo = "execo";
    rev = "a0a73f286ef6f337cc0746a6d6a9df3a8d1c9b43";
    sha256 = "0dsk1ybdhg7gx93bf0s3by6513sn0dj7i3n5sf4hwikgv78xc0hb";
  };

  doCheck=false;

  meta = with stdenv.lib; {
    description = "Python library that allows you to finely manage unix processes on thousands of remote hosts ";
    homepage    = http://execo.gforge.inria.fr/doc/latest-stable/execo.html;
    platforms   = platforms.unix;

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
