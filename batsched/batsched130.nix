{ stdenv, fetchurl,
  cmake, boost, gmp, rapidjson, intervalset, loguru,
  redox, hiredis, libev,
  cppzmq, zeromq
}:

stdenv.mkDerivation rec {
  name = "batsched-${version}";
  version = "1.3.0";

  src = fetchurl {
    url = "https://gitlab.inria.fr/batsim/batsched/repository/v${version}/archive.tar.gz";
    sha256 = "033m3b6ws5mx0q4sm04j4nn6zlssa33n5ips10p2ssvv5dxl5jls";
  };

  nativeBuildInputs = [ cmake boost gmp rapidjson intervalset loguru
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
