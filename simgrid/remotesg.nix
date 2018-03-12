{ simgrid, fetchgit }:

simgrid.overrideAttrs (oldAttrs: rec {
  version = "remotesg";
  name = "simgrid-${version}";

  src = fetchgit {
    url = "https://github.com/simgrid/simgrid.git";
    rev = "55da8092d6bc5acff7c392d2c9e5379351d88def";
    sha256 = "1b7cvbw9p2pxss44sp83hvc3dmjgy148z78qc6dljyfv76jp81lg";
  };

  doCheck = false;
  patches = [];
})
