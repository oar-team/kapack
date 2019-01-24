{ pybatsim, pythonPackages, procset}:

pybatsim.overrideAttrs (oldAttrs: rec {
  name = "pybatsim-${version}";
  version = "git";
  src = fetchTarball "https://gitlab.inria.fr/batsim/pybatsim/repository/master/archive.tar.gz";
  devTools = with pythonPackages; [
      # New dependencies
      procset
      # for testing and debug
      pytest
      ipython
      ipdb
      coverage
      # for doc generation
      sphinx
    ];# ++ [ batsim ];
  propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ devTools;
})
