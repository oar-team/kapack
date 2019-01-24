{ stdenv, fetchurl, cmake, simgrid, boost, gmp, rapidjson, openssl, git,
  redox, hiredis, libev, zeromq, docopt_cpp, pugixml, intervalset,
  installTestsDeps? false, batsched, python, pythonPackages, batexpe,
  redis, coreutils, netcat-gnu, procps, psmisc, which, doxygen, graphviz
}:

stdenv.mkDerivation rec {

  name = "batsim-${version}";
  version = "3.0.0";
  src = fetchurl {
    url = "https://gitlab.inria.fr/batsim/batsim/repository/v${version}/archive.tar.gz";
    sha256 = "1x2qblw7fvr6mrml1p8siybrdvrr71g5vdif368hjkhqmr1ld7wp";
  };

  nativeBuildInputs= [
    simgrid
    intervalset
    boost
    gmp
    rapidjson
    openssl
    redox
    hiredis
    libev
    zeromq
    docopt_cpp
    pugixml
    cmake
  ];

  buildInputs = stdenv.lib.optional installTestsDeps [
    pythonPackages.pandas
    netcat-gnu
    coreutils
    procps
    psmisc
    which
    batexpe
    batsched
    redis
    doxygen
    graphviz
  ];

  cmakeFlags = ["-DCMAKE_BUILD_TYPE=Debug"];

  enableParallelBuilding = true;

  # Disable tests by default
  doCheck = false;

  preCheck = ''
    # Patch tests script she bang
    patchShebangs ../test
  '';

  # Tunable ctest command. Used in the Batsim job of SimGrid's CI.
  CTEST_COMMAND = "ctest --output-on-failure";
  checkPhase = ''
    runHook preCheck
    ${stdenv.shell} ../ci/run-tests.bash
    ${stdenv.shell} ../ci/run-unittests.bash
  '';

  meta = with stdenv.lib; {
    description = "A batch scheduler simulator with a focus on realism that facilitates comparison.";
    homepage    = "https://github.com/oar-team/batsim";
    platforms   = platforms.unix;

    longDescription = ''
      Batsim is a Batch Scheduler Simulator that uses SimGrid as the
      platform simulator.
    '';
  };
}
