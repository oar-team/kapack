{ openmpi_rsg_plugins, simgrid, remote_simgrid }:

(openmpi_rsg_plugins.override {inherit simgrid; inherit remote_simgrid; }).overrideAttrs (oldAttrs: rec {
  name = "openmpi-rsg-plugins-${version}";
  version = "git";

  patches = [];
  src = fetchTarball "https://gitlab.inria.fr/mpoquet/openmpi-rsg-plugins/repository/master/archive.tar.gz";
  }
)
