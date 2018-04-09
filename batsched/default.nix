{ stdenv, fetchurl, cmake, simgrid_batsim, boost,
gmp, rapidjson, openssl, redox, hiredis, libev, cppzmq,
zeromq}:

stdenv.mkDerivation rec {
  name = "batsched-${version}";
  version = "1.2.0";

  src = fetchurl {
    url = "https://gitlab.inria.fr/batsim/batsched/repository/v${version}/archive.tar.gz";
    sha256 = "0ph3xgwlgrv3na3srnwqx2yxyw67kd2wsv5v5vdswdx9vk6h4al2";
  };

  nativeBuildInputs= [ simgrid_batsim  boost  gmp  rapidjson openssl redox hiredis libev cppzmq zeromq cmake ];

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "Batsim C++ scheduling algorithms.";
    homepage    = "https://gitlab.inria.fr/batsim/batsched";
    platforms   = platforms.unix;
  };
}
