{ simgrid_dev, fetchgit }:

simgrid_dev.overrideAttrs (oldAttrs: rec {
  name = "simgrid-temperature";

  rev = "8ca88f5944989c937734b5c28bfdd074aa990367";
  src = fetchTarball "https://github.com/simgrid/simgrid/archive/${rev}.tar.gz";

  patches = [ ./temperature-multiple.patch ];

  doCheck = false;
})
