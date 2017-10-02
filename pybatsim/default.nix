{ stdenv, pythonPackages, fetchurl, pypi_url }:

pythonPackages.buildPythonPackage rec {
    pname = "pybatsim";
    version = "1.2";
    name = "${pname}-${version}";

    src = fetchurl {
      url = pypi_url pname name;
      sha256 = "f87f4f756b2d5ae6b259720033b6a560d298c43a934f45915996f86b4b11746e";
    };

    propagatedBuildInputs = with pythonPackages; [
      sortedcontainers
      pyzmq
      redis
      click
      pandas
      docopt
    ];

    doCheck = false;

    meta = with stdenv.lib; {
      homepage = "https://gitlab.inria.fr/batsim/pybatsim";
      description = "Python Schedulers for Batsim";
      license = licenses.lgpl3;
    };
}
