{ batsched }:

batsched.overrideAttrs (oldAttrs: rec {
  name = "batsched-${version}";
  version = "1.4.0-dev";

  src = fetchTarball "https://gitlab.inria.fr/batsim/batsched/repository/master/archive.tar.gz";
})
