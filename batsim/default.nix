{ stdenv, fetchgit, cmake, simgrid_batsim, boost,
gmp, rapidjson, openssl, redox, hiredis, libev, cppzmq,
zeromq, execo, pkgs}:

stdenv.mkDerivation rec {
  name = "batsim";

  src = fetchgit {
    url = "https://github.com/freuk/batsim.git";
    rev = "refs/heads/master";
    sha256 = "1h9l87xhbavv8q3vjjhlf3n4dzjh85aq2n0xzxs16gqjsvimbcqa";
  };

  buildInputs = [
    simgrid_batsim boost gmp rapidjson openssl redox hiredis libev cppzmq zeromq
  ];
  nativeBuildInputs= [ cmake ];

  # Use debug flags to keep the assertions that make batsim more safe
  preConfigure =
    ''export cmakeFlags="$cmakeFlags -DCMAKE_BUILD_TYPE=Debug"'';

  doCheck = false; # change this to true to enable tests (experimental)

  checkTarget = "test";
  checkInputs = [
    pkgs.python35 pkgs.python35Packages.redis pkgs.python35Packages.pyyaml
    pkgs.python35Packages.sortedcontainers pkgs.python35Packages.pandas
    execo
  ];

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
