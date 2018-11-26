{ simgrid }:

simgrid.overrideAttrs (oldAttrs: rec {
  version = "for-batsim-1.4.0-or-2.0.0";
  rev = "587483ebe7882eae38ca9aba161fa168834c21e4";
  name = "simgrid-${version}";

  src = fetchTarball "https://framagit.org/batsim/simgrid/-/archive/${rev}/simgrid-${rev}.tar.gz";

  doCheck = false;
})
