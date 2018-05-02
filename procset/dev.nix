{ procset }:

procset.overrideAttrs (oldAttrs: rec {
  name = "procset-${version}";
  version = "git";

  src = fetchTarball "https://gitlab.inria.fr/bleuse/procset.py/repository/master/archive.tar.gz";
  }
)
