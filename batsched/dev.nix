{ batsched, intervalset, loguru }:

batsched.overrideAttrs (oldAttrs: rec {
  name = "batsched-${version}";
  version = "1.3-dev";

  src = fetchTarball "https://gitlab.inria.fr/batsim/batsched/repository/master/archive.tar.gz";
  nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ intervalset loguru ];
})
