{ stdenv, pkgs, fetchurl, pythonPackages, procset, sqlalchemy_utils, pybatsim, pytest_flask}:

pythonPackages.buildPythonPackage rec {
  name = "oar-${version}";
  version = "3.0.0.dev3";
  
  src = fetchurl {
    url = "https://github.com/oar-team/oar3/archive/3.0.0.dev3.tar.gz";
    sha256 = "149gs1k66il2pbr883132i7l7k2npi1ghdlgfr4c14n602ac1dmz";
  };
  
  propagatedBuildInputs = with pythonPackages; [
    pyzmq
    requests
    sqlalchemy
    alembic
    procset
    click
    simplejson
    flask
    tabulate
    psutil
    sqlalchemy_utils
    simpy
    redis
    pybatsim
    pytest_flask
  ];
  
  doCheck = false;
  
  meta = with stdenv.lib; {
    homepage = "https://github.com/oar-team/oar3";
    description = "Python library from OAR resources and tasks management system";
    license = licenses.lgpl3;
    };
}
