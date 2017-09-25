{ stdenv, fetchurl, cmake, simgrid_batsim, boost,
gmp, rapidjson, openssl, redox, hiredis, libev, cppzmq,
zeromq}:

stdenv.mkDerivation rec {
  name = "batsim";
  version = "1.2.0";

  src = fetchurl {
    url = "https://gitlab.inria.fr/batsim/batsim/repository/v${version}/archive.tar.gz";
    sha256 = "1sp2wanmb4q78bq00wrbd05kwb619y2wpp5nxz7js913qi29p2sk";
  };

  buildInputs = [ simgrid_batsim  boost  gmp  rapidjson openssl redox hiredis libev cppzmq zeromq];
  nativeBuildInputs= [ cmake ];

  meta = with stdenv.lib; {
    description = "A batch scheduler simulator with a focus on realism that facilitates comparison.";
    homepage    = https://github.com/oar-team/batsim;
    platforms   = platforms.unix;

    longDescription = ''
      Batsim is a Batch Scheduler Simulator that uses SimGrid as the
      platform simulator.
    '';
  };
}
