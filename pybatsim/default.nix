{ stdenv, pythonPackages, procset }:

pythonPackages.buildPythonPackage rec {
    pname = "pybatsim";
    version = "2.1.1";

    src = pythonPackages.fetchPypi {
      inherit pname version;
      sha256 = "0awm4yamfqpmd5mb85xsrz1ip56pam1rrn0w9m87lr7viq9vmcip";
    };

    buildInputs = with pythonPackages; [
      autopep8
      coverage
      ipdb
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
