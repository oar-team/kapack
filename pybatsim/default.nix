{ stdenv, pkgs, fetchgit, python36Packages, procset}:

python36Packages.buildPythonPackage rec {
    pname = "pybatsim";
    version = "1.2";
    name = "${pname}-${version}";

    src = pkgs.fetchurl {
      url = "mirror://pypi/p/${pname}/${name}.tar.gz";
      sha256 = "f87f4f756b2d5ae6b259720033b6a560d298c43a934f45915996f86b4b11746e";
    };

    propagatedBuildInputs = with python36Packages; [
      sortedcontainers
      pyzmq
      redis
      click
      pandas
      docopt
    ];

    doCheck = false;

    meta = {
      homepage = "https://gitlab.inria.fr/batsim/pybatsim";
      description = "Python Schedulers for Batsim";
      license = stdenv.licenses.lgpl3;
    };
}
