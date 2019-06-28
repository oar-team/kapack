{ remote_simgrid, simgrid }:

(remote_simgrid.override {inherit simgrid;}).overrideAttrs (oldAttrs: rec {
  name = "remote-simgrid-${version}";
  version = "git";

  patches = [];
  src = fetchTarball "https://framagit.org/simgrid/remote-simgrid/-/archive/master/remote-simgrid-master.tar.gz";
  hardeningDisable = [ "all" ];
  dontStrip = true;
  }
)
