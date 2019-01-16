{ stdenv, pkgs, pythonPackages, humanfriendly }:

pythonPackages.buildPythonPackage rec {
    pname = "coloredlogs";
    version = "7.3";
    name = "${pname}-${version}";

    src = pythonPackages.fetchPypi {
      inherit pname version;
      sha256 = "894641ed5e8c48e01fa0b1d62b15cd32030c6c16e1dda42f6ce5f966ac558cae";
    };

    propagatedBuildInputs = [
      humanfriendly
    ];

    doCheck = false;

    meta = with stdenv.lib; {
      homepage = "https://coloredlogs.readthedocs.io";
      description = "Colored terminal output for Python's logging module";
      license = licenses.mit;
    };
}
