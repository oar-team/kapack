{ stdenv, pkgs, fetchgit, pythonPackages}:

pythonPackages.buildPythonPackage rec {
  name = "procset-${version}";
  version = "v1.0";

  src = fetchgit {
    url = "https://gitlab.inria.fr/bleuse/procset.py.git";
    rev = version;
    sha256 = "1cnmbw4sgl9156lgvakdkpjr7mgd2wasqz1zml9qzk29p705420z";
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
