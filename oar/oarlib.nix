{stdenv, pythonPackages, procset}:

pythonPackages.buildPythonPackage rec {
  pname = "oar-lib";
  version = "0.4.1";
  name = "${pname}-${version}";

  src = pythonPackages.fetchPypi {
    inherit pname version;
    sha256 = "1xpjg3jp6a8im0aipz77b5cn3mv7vqxzkzflhh4mvddb147r6pi8";
  };

  propagatedBuildInputs = with pythonPackages; [
    alembic
    sqlalchemy
  ];

  doCheck  = false;
  meta = with stdenv.lib; {
    description = "Python OAR Common Library";
    homepage    = https://github.com/oar-team/oar3;
    platforms   = platforms.unix;
    # amybe
    license     = license.bsd3;
    broken = false;
    longDescription = ''
      Python OAR Common Library.
    '';
  };
}
