{ stdenv, fetchgit, cmake, simgrid_batsim, boost,
gmp, rapidjson, openssl, redox, hiredis, libev, cppzmq,
zeromq, execo, pkgs}:

let
  checkInstall = pkgs.python35.withPackages (
    ps: [ps.redis ps.pyyaml ps.sortedcontainers ps.pandas execo]
  );
in
stdenv.mkDerivation rec {
  name = "batsim";

  src = fetchgit {
    url = "https://github.com/freuk/batsim.git";
    rev = "refs/heads/master";
    sha256 = "1h9l87xhbavv8q3vjjhlf3n4dzjh85aq2n0xzxs16gqjsvimbcqa";
  };

  buildInputs = [
    simgrid_batsim boost gmp rapidjson openssl redox hiredis libev cppzmq zeromq
    pkgs.python35 checkInstall ];
  nativeBuildInputs= [ cmake ];

  # Use debug flags to keep the assertions that make batsim more safe
  preConfigure =
    ''export cmakeFlags="$cmakeFlags -DCMAKE_BUILD_TYPE=Debug"'';

  doCheck = true; # change this to true to enable tests (experimental)

  checkTarget = "test";

  tototatat = [  ];

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
