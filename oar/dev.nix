{oar, pythonPackages, procset, pytest_flask}:

oar.overrideAttrs (oldAttrs: rec {
  name = "oar-${version}";
  #src = /home/auguste/dev/oar3;
  version = "git";
  src = fetchTarball "https://github/repository/master/archive.tar.gz";
  devTools = with pythonPackages; [
      # for testing and debug
      pytest
      #pytest_flask
      ipython
      ipdb
      # for doc generation
      sphinx
      redis #to migrate to default.nix when it'll used
    ];
  propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ devTools;
})
