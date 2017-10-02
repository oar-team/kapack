{ stdenv, pkgs, fetchgit, python36Packages}:

python36Packages.buildPythonPackage rec {
  name = "procset-git";

  src = fetchgit {
    url = "https://gitlab.inria.fr/bleuse/procset.py.git";
    rev = "c1b3c9ce3c86a10423afa6f29b94ec5da29e7ec5";
    sha256 = "1fwm3s8rzmkp7nx2xsnyazp8dldhfgw4klafp25p5xxc0qxzimxm";
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
