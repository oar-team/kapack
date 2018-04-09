{ stdenv, fetchurl, batsim }:
batsim.overrideAttrs (attrs: rec {
  name = "batsim-${version}";
  version = "1.4.0";
  src = fetchurl {
    url = "https://gitlab.inria.fr/batsim/batsim/repository/v${version}/archive.tar.gz";
    sha256 = "01pm96zgy4pdykkss5viwfni20bnhccxnbrxd0mwn5rg8af0jcjb";
  };
})
