{ stdenv, fetchurl, cmake, simgrid_batsim, boost,
gmp, rapidjson, openssl, redox, hiredis, libev, cppzmq,
zeromq}:

stdenv.mkDerivation rec {
  name = "batsched";
  version = "git";

  src = fetchurl {
    url = "https://gitlab.inria.fr/batsim/batsched/repository/v1.0.0/archive.tar.gz";
    sha256 = "0y44gax22c2774g6jypi47qbnv61m19n38j5d21kc3wp49xl40lr";
  };

  nativeBuildInputs= [ simgrid_batsim  boost  gmp  rapidjson openssl redox hiredis libev cppzmq zeromq cmake ];

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "Batsim C++ scheduling algorithms.";
    homepage    = "https://gitlab.inria.fr/batsim/batsched";
    platforms   = platforms.unix;
  };
}
