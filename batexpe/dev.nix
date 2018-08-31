{ batexpe, batsched, batsim }:
(
  # enable tests and coverage dependancies
  # Batsim and Batsched version can be selected using for example:
  #   nix-build -E "with import ./. {}; batexpe_dev.override{ batsched = batsched_dev; }"
  batexpe.override {
    installTestsDeps = true;
    installCoverageDeps = true;
    inherit batsim;
    inherit batsched;
  }

).overrideAttrs (attrs: rec {
    name = "batexpe-${version}";
    version = "2.0-dev";
    src = fetchTarball "https://gitlab.inria.fr/batsim/batexpe/repository/master/archive.tar.gz";
})
