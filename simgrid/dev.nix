{ simgrid }:

(simgrid.override { debug = true; }).overrideAttrs (oldAttrs: rec {
  name = "simgrid-${version}";
  version = "3.21-dev";

  patches = [ ];
  src = fetchTarball "https://framagit.org/simgrid/simgrid/-/archive/master/simgrid-master.tar.bz2";

  # Avoid debug information striping
  hardeningDisable = [ "all" ];
  dontStrip = true;
  doCheck = false;
})
