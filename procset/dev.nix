{ procset }:

procset.overrideAttrs (oldAttrs: rec {
  name = "procset-${version}";
  version = "1.0-dev";

  src = fetchTarball "https://gitlab.inria.fr/bleuse/procset.py/repository/master/archive.tar.gz";
  }
)
