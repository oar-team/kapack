{stdenv, fetchgit, cmake, simgrid_batsim, boost_gcc6,
gmp, rapidjson, openssl, redox, hiredis, libev, cppzmq,
zeromq, execo, gcc6, git, python35Packages, redis}:

stdenv.mkDerivation rec {
  name = "batsim";
  version = "unstable";

  src = fetchgit {
    url = "https://gitlab.inria.fr/batsim/batsim.git";
    rev = "f4fe044055386758f3f49859eef789a2a91ec1f9";
    fetchSubmodules = true;
  };

  # Use debug flags to keep the assertions that make batsim more safe
  preConfigure =
    ''export cmakeFlags="$cmakeFlags -DCMAKE_BUILD_TYPE=Debug -Dignore_assertions=OFF -Dtreat_warnings_as_errors=OFF"'';

  buildInputs = [
    simgrid_batsim boost_gcc6 gmp rapidjson openssl redox hiredis
    libev cppzmq zeromq
  ];
  nativeBuildInputs = [ cmake gcc6 ];

  enableParallelBuilding = true;

  # change this to true to enable tests (experimental)
  doInstallCheck = true;
  preInstallCheck = ''
    export PATH=$PATH:$out/bin
    redis-server&
    export REDIS_PID=$!
  '';
  postInstallCheck = ''
    kill $REDIS_PID
    rm -rf /tmp/batsim_*
  '';
  propagatedNativeBuildInputs = [
    python35Packages.redis
    python35Packages.pyyaml
    python35Packages.sortedcontainers
    python35Packages.pandas
    python35Packages.pyzmq
    python35Packages.ipython
    execo
    redis
  ];
  installCheckTarget = "CTEST_OUTPUT_ON_FAILURE=1 test";

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
