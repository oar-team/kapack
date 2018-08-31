{ procset }:

procset.overrideAttrs (oldAttrs: rec {
  name = "procset-${version}";
  version = "0.5-dev";

  src = fetchTarball "https://gitlab.inria.fr/bleuse/procset.py/repository/master/archive.tar.gz";
  }
)
