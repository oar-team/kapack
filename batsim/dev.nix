{ stdenv, batsim, simgrid, intervalset
, installTestsDeps ? true, batsched, pybatsim, python, pythonPackages, batexpe, redis, coreutils
, buildDoc ? true, doxygen, graphviz
}:
(batsim.override {inherit simgrid;}).overrideAttrs (attrs: rec {
    name = "batsim-${version}";
    version = "3.0-dev";
    src = fetchTarball "https://gitlab.inria.fr/batsim/batsim/repository/master/archive.tar.gz";

    expeToolInputs = [
      pythonPackages.pandas
      batexpe
    ];
    testInputs = [
      (python.withPackages (ps: [ pybatsim ]))
      batsched
      redis
    ];
    docInputs = [
      doxygen
      graphviz
    ];
    nativeBuildInputs =
    attrs.nativeBuildInputs
    ++ [intervalset]
    ++ stdenv.lib.optional installTestsDeps (testInputs ++ expeToolInputs)
    ++ stdenv.lib.optional buildDoc docInputs;

    enableParallelBuilding = true;

    # Remove previous builds to avoid CMake complain
    preConfigure = "rm -rf ./build/*";

    # Disable checks by default to enable installing broken version
    doCheck = false;

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
