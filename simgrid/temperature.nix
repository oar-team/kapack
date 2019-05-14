{ simgrid_dev, fetchgit }:

simgrid_dev.overrideAttrs (oldAttrs: rec {
  name = "simgrid-temperature";

  rev = "52fa9e20e056119074cd759141021286786655c5";
  src = fetchTarball "https://github.com/simgrid/simgrid/archive/${rev}.tar.gz";

  #patches = [ ./temperature-working.patch ];
  patches = [ ./temperature-multiple.patch ];

  doCheck = false;
})
