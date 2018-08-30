{ stdenv, fetchurl,
  cmake, boost, gmp, rapidjson, openssl,
  redox, hiredis, libev,
  cppzmq, zeromq
}:

stdenv.mkDerivation rec {
  name = "batsched-${version}";
  version = "1.2.1";

  src = fetchurl {
    url = "https://gitlab.inria.fr/batsim/batsched/repository/v${version}/archive.tar.gz";
    sha256 = "0apdbx48ywazi9y8q7hylix8ngw52qvr11i5jq8c4pl6ip1hbym3";
  };

  nativeBuildInputs = [ cmake boost gmp rapidjson openssl
    redox hiredis libev
    cppzmq zeromq
  ];

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "Batsim C++ scheduling algorithms.";
    homepage    = "https://gitlab.inria.fr/batsim/batsched";
    platforms   = platforms.unix;
  };
}
