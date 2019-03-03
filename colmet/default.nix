{ stdenv, fetchFromGitHub, python27Packages, pkgs, zeromq }:

python27Packages.buildPythonPackage rec {

  src = fetchFromGitHub {
    owner = "adfaure";
    repo = "colmet";
    rev = "88de18da67c9a24a2f3b4a5f30f735b382cfe0ff";
    sha256 = "0hswgmjbs5yglsgmxmr3qra8zfc3w7ds3clxqihhhb96q7ppk5rg";
  };

  propagatedBuildInputs = with python27Packages; [
    pytest
    tables
    pyinotify
    pyzmq
  ];

  name = "colmet-0.5.5dev1";

  # Tests do not pass
  doCheck = false;

  # Use this patch to enable cwd options for Process and make the engin
  # parameters override works
  # patches = [ ];

  meta = with stdenv.lib; {
    description = "Python library that allows you to finely manage unix processes on thousands of remote hosts";
    homepage    = https://github.com/oar-team/colmet;
    platforms   = platforms.unix;
    licence     = licenses.gpl2;
    longDescription = ''
    Colmet is a monitoring tool to collect metrics about jobs running in a
    distributed environnement, especially for gathering metrics on clusters
    and grids. It provides currently several backends : - taskstats: fetch
    task metrics from the linux kernel
    - stdout: display the metrics on the terminal
    - zeromq: transport the metrics across the network
    - hdf5: store the metrics on the filesystem
    '';
  };
}
