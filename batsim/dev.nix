{ stdenv, fetchurl, cmake, simgrid, boost, gmp, rapidjson, openssl, git,
  redox, hiredis, libev, zeromq, docopt_cpp, pugixml, intervalset,
  installTestsDeps? false, batsched, python, pythonPackages, batexpe,
  redis, coreutils, netcat-gnu, procps, psmisc, which, doxygen, graphviz
}:

stdenv.mkDerivation rec {

  name = "batsim-${version}";
  version = "3.1.0-dev";
  src = fetchTarball "https://gitlab.inria.fr/batsim/batsim/repository/master/archive.tar.gz";

  #src = fetchurl {
  #  url = "https://gitlab.inria.fr/batsim/batsim/repository/v${version}/archive.tar.gz";
  #  sha256 = "1r5yfj984xbzlgv5zzai2w19z174s7j52nkdzfsgfqqrzzz5g3r2";
  #};

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

  buildInputs = stdenv.lib.optionals installTestsDeps [
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


  # Remove previous builds to avoid CMake complain
  preConfigure = "rm -rf ./build/*";

  # Disable checks by default to enable installing broken version
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
