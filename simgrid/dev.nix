{ simgrid }:

(simgrid.override { debug = true; }).overrideAttrs (oldAttrs: rec {
  name = "simgrid-${version}";
  version = "git";

  patches = [];
  src = fetchTarball "https://github.com/simgrid/simgrid/archive/master.tar.gz";

  # Avoid debug information striping
  dontStrip = true;
  doCheck = false;
})
