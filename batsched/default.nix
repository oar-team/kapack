{ stdenv, fetchurl, cmake, simgrid_batsim, boost,
gmp, rapidjson, openssl, redox, hiredis, libev, cppzmq,
zeromq}:

stdenv.mkDerivation rec {
  name = "batsched";
  version = "git";

  src = fetchurl {
    url = "https://gitlab.inria.fr/batsim/batsched/repository/master/archive.tar.gz";
    sha256 = "1db6c75c6e68f2eff15bf0b69dafa5b51c382cf3b8643212dc9dcc73e6de8ba8";
  };

  nativeBuildInputs= [ simgrid_batsim  boost  gmp  rapidjson openssl redox hiredis libev cppzmq zeromq cmake ];

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "Batsim C++ scheduling algorithms.";
    homepage    = "https://gitlab.inria.fr/batsim/batsched";
    platforms   = platforms.unix;
  };
}
