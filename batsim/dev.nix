{ stdenv, batsim
, clangSupport ? false, clang
, doTests ? true, batsched, pybatsim, coloredlogs, execo, pythonPackages
, redis, python, R, rPackages, psmisc, iproute, coreutils
, buildDoc ? true, doxygen, graphviz
}:
batsim.overrideAttrs (attrs: rec {
    name = "batsim-${version}";
    version = "git";
    src = fetchTarball "https://gitlab.inria.fr/batsim/batsim/repository/master/archive.tar.gz";
    preConfigure = "rm -rf ./build/*";
    expeToolInputs = with pythonPackages; [
      async-timeout
      coloredlogs
      pandas
      pyyaml
      execo
    ];
    testInputs = [
      (python.withPackages (ps: [ pybatsim ]))
      batsched
      redis
      R
      rPackages.ggplot2
      rPackages.dplyr
      rPackages.scales
      psmisc # for pstree
      iproute # for ss
    ];
    docInputs = [
      doxygen
      graphviz
    ];
    nativeBuildInputs =
    attrs.nativeBuildInputs
    ++ stdenv.lib.optional clangSupport [clang]
    ++ stdenv.lib.optional doTests (testInputs ++ expeToolInputs)
    ++ stdenv.lib.optional buildDoc docInputs;

    configurePhase = stdenv.lib.optionalString clangSupport ''
      export CC=clang
      export CXX=clang++
    '';

    # Make autocompletion works for YCM
    cmakeFlags = attrs.cmakeFlags ++ ["-DCMAKE_EXPORT_COMPILE_COMMANDS=ON"];

    enableParallelBuilding = true;

    doCheck = true;
    preCheck = ''
      # Patch tests script she bang
      patchShebangs ..

      # Patch inside scripts in the yaml test files that are not catch by
      # patchShebangs utility
      find .. -type f | xargs sed -i -e 's#\(.*\)/usr/bin/env\(.*\)#\1${coreutils}/bin/env\2#'

      # start Redis and keep PID
      redis-server > /dev/null &
      REDIS_PID=$!
    '';
    checkPhase = ''
      runHook preCheck

      PATH="$(pwd):$PATH" ctest --output-on-failure -E 'remote'

      runHook postCheck
      '';
    postCheck = ''
      kill $REDIS_PID
    '';
})
