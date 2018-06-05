{ remote_simgrid }:

remote_simgrid.overrideAttrs (oldAttrs: rec {
  name = "remote-simgrid-${version}";
  version = "git";

  patches = [];
  src = fetchTarball "https://github.com/simgrid/remote-simgrid/archive/master.tar.gz";
  }
)
