{ stdenv, pkgs, fetchgit, pythonPackages}:

pythonPackages.buildPythonPackage rec {
  name = "accasim-${version}";
  version = "v1.0.0";

  src = fetchgit {
    url = "https://github.com/cgalleguillosm/accasim";
    sha256 = "0s7saz6v6yii52p8nvz0zryd1d47zwi1c44c99my5zqkgb6l080i";
  };

  LC_ALL = "en_US.UTF-8";

  buildInputs = with pythonPackages; [
    matplotlib
    psutil
    sortedcontainers
    numpy
    scipy
  ];

  meta = with stdenv.lib; {
    longDescription = ''
      AccaSim is a Workload management [sim]ulator for [H]PC systems, useful
      for developing dispatchers and conducting controlled experiments in HPC
      dispatching research. It is scalable and highly customizable, allowing to
      carry out large experiments across different workload sources, resource
      settings, and dispatching methods.
    '';
    description = ''HPC Simulator for Workload Management'';
    homepage    = "https://accasim.readthedocs.io/en/latest";
    platforms   = platforms.unix;
    license     = licenses.mit;
    broken      = false;
  };
}
