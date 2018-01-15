{ simgrid, fetchgit }:

simgrid.overrideAttrs (oldAttrs: rec {
  version = "batsim";
  name = "simgrid-${version}";

  src = fetchgit {
    url = "https://github.com/freuk/simgrid.git";
    rev = "refs/heads/batsim";
    sha256 = "042ac6dhqlb9kbprsjhxx7jklpwyl2wf6rr39fs0pwninzyzxpxl";
  };

  doCheck = false;
})
