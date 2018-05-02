{ stdenv, pkgs, fetchgit, pythonPackages}:

pythonPackages.buildPythonPackage rec {
  name = "procset-${version}";
  version = "v0.4";

  src = fetchgit {
    url = "https://gitlab.inria.fr/bleuse/procset.py.git";
    rev = version;
    sha256 = "07vcsag212ln2fgrr4pj3n4d5gwqrm7wacksg57wq4lf0qggnr5d";
  };

  LC_ALL = "en_US.UTF-8";
  buildInputs = [ pkgs.glibcLocales ];

  meta = with stdenv.lib; {
    description = ''
      Toolkit to manage sets of closed intervals.
      procset is a pure python module to manage sets of closed intervals. It can be
      used as a small python library to manage sets of resources, and is especially
      useful when writing schedulers.'';
    homepage    = "https://gitlab.inria.fr/bleuse/procset.py";
    platforms   = platforms.unix;
    license     = licenses.lgpl3;
  };
}
