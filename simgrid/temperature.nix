{ simgrid_dev_working, fetchgit }:

simgrid_dev_working.overrideAttrs (oldAttrs: rec {
  name = "simgrid-temperature";

  #src = /home/mommess/Documents/BatSimGrid/simgrid ;
  #patches = [];
  patches = [ ./temperature-working.patch ];

  #Simgrid-working
  #rev = "b88233071eaaef45c854e84a8c7b460ab5793b7d";
  #src = fetchTarball "https://github.com/simgrid/simgrid/archive/${rev}.tar.gz";

  #doCheck = false;
})
