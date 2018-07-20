{ simgrid, fetchgit, glibcLocales }:

simgrid.overrideAttrs (oldAttrs: rec {
  version = "remotesg";
  name = "simgrid-${version}";

  src = fetchgit {
    url = "https://github.com/simgrid/simgrid.git";
    rev = "b88233071eaaef45c854e84a8c7b460ab5793b7d";
    sha256 = "1fm2p6bkvrq0y0wv9pvv1liav0yj9220z9357ibpnbplrll4q9ip";
  };

  LC_ALL = "en_US.UTF-8";
  buildInputs = [ glibcLocales ];

  doCheck = false;
  patches = [];
})
