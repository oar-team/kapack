{ stdenv, pythonPackages, procset }:

pythonPackages.buildPythonPackage rec {
    pname = "pybatsim";
    version = "3.0.0";

    src = pythonPackages.fetchPypi {
      inherit pname version;
      sha256 = "1d74kfzarxqd2l186hlf2qj4k2qzspgdi3isrdlxwvhyz9wwdr7j";
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
