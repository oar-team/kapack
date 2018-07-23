{ openmpi_rsg, openmpi, openmpi_rsg_plugins, }:

(openmpi_rsg.override {inherit openmpi; inherit openmpi_rsg_plugins; }).overrideAttrs (oldAttrs: rec {
# name = "openmpi-3.1.1";
  name = "openmpi-rsg-d"; # Length must equal openmpi package's
  }
)
