{ stdenv, pkgs, pypi_url }:

pkgs.python36Packages.buildPythonPackage rec {
    pname = "humanfriendly";
    version = "7.3";
    name = "${pname}-${version}";

    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/0e/1b/154666b208625dd4d946e949c4aa39d9150f4dac00796f0ec6b9a3abac7e/humanfriendly-4.4.1.tar.gz";
      sha256 = "f1ebb406d37478228b92543c12c27c9a827782d8d241260b3a06512c7f7c3a5e";
    };

    doCheck = false;

    meta = with stdenv.lib; {
      homepage = "https://humanfriendly.readthedocs.io";
      description = "Human friendly output for text interfaces using Python";
      license = licenses.mit;
    };
}
