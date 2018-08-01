{ openmpi_rsg_plugins, simgrid, remote_simgrid, openmpi,
  fetchgit }:

(openmpi_rsg_plugins.override {inherit simgrid; inherit remote_simgrid;
  inherit openmpi; }).overrideAttrs (oldAttrs: rec {
  name = "openmpi-rsg-plugins-${version}";
  version = "git";

  patches = [];

  src = fetchgit {
    url = "https://framagit.org/simgrid/openmpi-rsg-plugins.git";
    rev = "1ddc0d82d2609051c30d0c67aa6d05894e84e5f9";
    sha256 = "044ihb83adbkxz64lmzn7nb2ppy7wz8r8fgcr3w7ma91r7kpjln3";
  };
  }
)
