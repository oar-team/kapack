{ simgrid }:

simgrid.overrideAttrs (oldAttrs: rec {
  name = "simgrid-${version}";
  version = "git";

  patches = [];
  src = fetchTarball "https://github.com/simgrid/simgrid/archive/master.tar.gz";
  }
)
