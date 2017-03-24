{ stdenv, fetchgit, cmake, simgrid_batsim, boost,
gmp, rapidjson, openssl, redox, hiredis, libev, cppzmq,
zeromq}:

stdenv.mkDerivation rec {
  name = "batsim";

  src = fetchgit {
    url = "https://github.com/freuk/batsim.git";
    rev = "refs/heads/master";
    sha256 = "1h9l87xhbavv8q3vjjhlf3n4dzjh85aq2n0xzxs16gqjsvimbcqa";
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
