{ openmpi_rsg_plugins }:

openmpi_rsg_plugins.overrideAttrs (oldAttrs: rec {
  name = "openmpi-rsg-plugins-${version}";
  version = "git";

  patches = [];
  src = fetchTarball "https://gitlab.inria.fr/mpoquet/openmpi-rsg-plugins/repository/master/archive.tar.gz";
  }
)
