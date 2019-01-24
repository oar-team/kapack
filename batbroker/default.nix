{ pkgs,
  stdenv
}:
pkgs.buildGoPackage rec {
  name = "batbroker-${version}";
  version = "1.2.0";

  goPackagePath = "gitlab.inria.fr/batsim/batbroker";

  # to update use:
  # $ nix-prefetch-git url rev
  src = pkgs.fetchgit {
    rev = "v${version}";
    url = "https://gitlab.inria.fr/batsim/batbroker.git";
    sha256 = "1jvhlqlkzwiz01vgsx8mikcls3qzyazfd39j2v3mdv51ld7xfcax";
  };

  goDeps = ./deps.nix;

  LC_ALL = "C";

  buildInputs = with pkgs; [
    pkgconfig
    go
    zeromq
  ];

  meta = with stdenv.lib; {
    description = "Broker for the BeBida on Batsim project.";
    homepage    = "https://gitlab.inria.fr/batsim/batbroker";
    platforms   = platforms.unix;
  };
}
