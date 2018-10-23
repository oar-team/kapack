{ simgrid_dev_working, fetchgit }:

simgrid_dev_working.overrideAttrs (oldAttrs: rec {
  name = "simgrid-temperature";

  patches = [ ./temperature-working.patch ];

  #doCheck = false;
})
