{ pkgs,
  stdenv
}:
pkgs.buildGoPackage rec {
  name = "batbroker-${version}";
  version = "1.2.0";

  goPackagePath = "gitlab.inria.fr/batsim/batbroker";

  src = pkgs.fetchurl {
    url = "https://gitlab.inria.fr/batsim/batbroker/repository/v${version}/archive.tar.gz";
    sha256 = "0vqqcgw74c9qcya5ic9ssc45p52gd57iqlw6v52gbs01hb4k746r";
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
