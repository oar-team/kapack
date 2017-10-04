{ stdenv, pkgs, pypi_url, humanfriendly }:

pkgs.python36Packages.buildPythonPackage rec {
    pname = "coloredlogs";
    version = "4.4.1";
    name = "${pname}-${version}";

    src = pkgs.fetchurl {
      url = "https://pypi.python.org/packages/b4/41/97147119b23b429e5337969c6c389eab7ef09e284d8febed936cec9d7b84/coloredlogs-7.3.tar.gz";
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
