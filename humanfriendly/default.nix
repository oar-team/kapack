{ stdenv, pkgs, pythonPackages }:

pythonPackages.buildPythonPackage rec {
    pname = "humanfriendly";
    version = "4.4.1";
    name = "${pname}-${version}";

    src = pythonPackages.fetchPypi {
      inherit pname version;
      sha256 = "f1ebb406d37478228b92543c12c27c9a827782d8d241260b3a06512c7f7c3a5e";
    };

    doCheck = false;

    meta = with stdenv.lib; {
      homepage = "https://humanfriendly.readthedocs.io";
      description = "Human friendly output for text interfaces using Python";
      license = licenses.mit;
    };
}
