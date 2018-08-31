{ simgrid }:

(simgrid.override { debug = true; }).overrideAttrs (oldAttrs: rec {
  name = "simgrid-${version}";
  version = "3.21-dev";

  patches = [ ./fix_smpi_host_init.patch ];
  src = fetchTarball "https://github.com/simgrid/simgrid/archive/master.tar.gz";

  # Avoid debug information striping
  dontStrip = true;
  doCheck = false;
})
