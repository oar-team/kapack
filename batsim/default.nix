{ stdenv, fetchgit, cmake, simgrid_batsim, boost_gcc6,
gmp, rapidjson, openssl, redox, hiredis, libev, cppzmq,
zeromq, execo, gcc6, git, python35Packages}:

stdenv.mkDerivation rec {
  name = "batsim";

  src = fetchgit {
    url = "https://gitlab.inria.fr/batsim/batsim.git";
    rev = "refs/heads/master";
    fetchSubmodules = true;
  };

  # Use debug flags to keep the assertions that make batsim more safe
  preConfigure =
    ''export cmakeFlags="$cmakeFlags -DCMAKE_BUILD_TYPE=Debug"'';

  buildInputs = [
    gcc6 simgrid_batsim boost_gcc6 gmp rapidjson openssl redox hiredis
    libev cppzmq zeromq
  ];
  nativeBuildInputs= [ cmake ];

  # change this to true to enable tests (experimental)
  # doCheck = true;
  # propagatedBuildInputs = [
  #   python35Packages.redis
  #   python35Packages.pyyaml
  #   python35Packages.sortedcontainers
  #   python35Packages.pandas
  #   execo
  # ];
  # checkTarget = "CTEST_OUTPUT_ON_FAILURE=1 test";

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
