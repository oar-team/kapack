{ stdenv, fetchFromGitHub, python27Packages, pkgs, zeromq }:

python27Packages.buildPythonPackage rec {

  src = fetchFromGitHub {
    owner = "oar-team";
    repo = "colmet";
    rev = "56e1d9098dea0df340d7798f4cc6d4ba66c567b0";
    sha256 = "1cz97l84xhz3rzhd5rfa92sc7zx8s3mhq71y0fj2si9j5bmcsm0b";
  };

  propagatedBuildInputs = with python27Packages; [
    pytest
    tables
    pyinotify
    pyzmq
  ];

  name = "colmet-0.5.4";

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
