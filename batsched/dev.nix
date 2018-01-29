{ batsched }:

batsched.overrideAttrs (oldAttrs: rec {
  name = "batsched-${version}";
  version = "git";

  src = fetchTarball "https://gitlab.inria.fr/batsim/batsched/repository/master/archive.tar.gz";
  }
)
