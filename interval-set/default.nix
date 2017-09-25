{ stdenv, fetchFromGitHub, python35Packages}:

#
# WARNING: This package is deprecated in favor of procset.py
#

python36Packages.buildPythonPackage rec {
  name = "interval-set-git";

  src = fetchFromGitHub {
    owner = "oar-team";
    repo = "interval_set";
    rev = "2a71edae679a2571f7d4c6d96dab1b6d0666aaaf";
    sha256 = "0mknypknkm09r8p8drlicvkh9asx9bmqf7kwfp2nk9bbwxz608ck";
  };

  meta = with stdenv.lib; {
    description = "Closed interval set toolkit for resources representation in scheduling";
    homepage    = https://github.com/oar-team/interval_set;
    platforms   = platforms.unix;
  };
}
