{ stdenv, pythonPackages, fetchurl, procset }:

pythonPackages.buildPythonPackage rec {
    name = "pybatsim-2.1";

    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/75/b9/a19f5b18349221185ade8c7b21f25800b3094f5d13f3af16d8c08c4ab220/pybatsim-2.1.tar.gz";
      sha256 = "1qf618vc57x3fbxzm73ya87j98dx5mjpijlwsxbsjlh4kpr153ym";
    };

    buildInputs = with pythonPackages; [
      autopep8
      coverage
    ];
    propagatedBuildInputs = with pythonPackages; [
      sortedcontainers
      pyzmq
      redis
      click
      pandas
      docopt
      procset
    ];

    doCheck = false;

    meta = with stdenv.lib; {
      homepage = "https://gitlab.inria.fr/batsim/pybatsim";
      description = "Python Schedulers for Batsim";
      license = licenses.lgpl3;
    };
}
