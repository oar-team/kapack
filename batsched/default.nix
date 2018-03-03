{ stdenv, fetchurl, cmake, simgrid_batsim, boost,
gmp, rapidjson, openssl, redox, hiredis, libev, cppzmq,
zeromq}:

stdenv.mkDerivation rec {
  name = "batsched-${version}";
  version = "v1.1.0";

  src = fetchurl {
    url = "https://gitlab.inria.fr/batsim/batsched/repository/${version}/archive.tar.gz";
    sha256 = "0i69ccdxxbajlg2d3l88zv3vb90l7vlg75zxr5mc0akfcpvvi7j7";
  };

  nativeBuildInputs= [ simgrid_batsim  boost  gmp  rapidjson openssl redox hiredis libev cppzmq zeromq cmake ];

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "Batsim C++ scheduling algorithms.";
    homepage    = "https://gitlab.inria.fr/batsim/batsched";
    platforms   = platforms.unix;
  };
}
