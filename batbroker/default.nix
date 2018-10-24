{ pkgs,
  stdenv
}:
pkgs.buildGoPackage rec {
  name = "batbroker-${version}";
  version = "1.0";

  goPackagePath = "gitlab.inria.fr/batsim/batbroker";

  src = pkgs.fetchurl {
    url = "https://gitlab.inria.fr/batsim/batbroker/repository/${version}/archive.tar.gz";
    sha256 = "0qlp3ig22d83j6bf004j313lx0d7i3hibyskjs01bsakvji9v1aj";
  };  goDeps = ./deps.nix;

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
