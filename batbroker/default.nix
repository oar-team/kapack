{ pkgs,
  stdenv
}:
pkgs.buildGoPackage rec {
  name = "batbroker-${version}";
  version = "1.2.0";

  goPackagePath = "gitlab.inria.fr/batsim/batbroker";

  src = pkgs.fetchurl {
    url = "https://gitlab.inria.fr/batsim/batbroker/repository/v${version}/archive.tar.gz";
    sha256 = "1i3gaxcg2rwxb59g4gihpgrk8rn5ybzzn43lqws9samikr0vz70w";
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
