{ stdenv, pkgs, batsim
, clangSupport ? false, clang
, doTests ? true, coloredlogs, execo, batsched, pybatsim
, buildDoc ? true
}:
{
  batsim_ci = batsim.overrideDerivation (attrs: rec {
    version = "dev";
    #src = /builds/batsim/batsim/src;
    src = /home/mmercier/Projects/batsim;
    preConfigure = "rm -rf ./build/*";
    expeToolInputs = with pkgs.python36Packages; [
      async-timeout
      coloredlogs
      pandas
      pyyaml
      execo
    ];
    testInputs = with pkgs; [
      (python36.withPackages (ps: [ pybatsim ]))
      batsched
      redis
      R
      rPackages.ggplot2
      rPackages.dplyr
      rPackages.scales
      psmisc # for pstree
      iproute # for ss
    ];
    docInputs = with pkgs; [
      doxygen
      graphviz
    ];
    buildInputs =
    attrs.buildInputs
    ++ stdenv.lib.optional clangSupport clang
    ++ stdenv.lib.optional doTests (testInputs ++ expeToolInputs)
    ++ stdenv.lib.optional buildDoc docInputs;

    configurePhase = stdenv.lib.optionalString clangSupport ''
      export CC=clang
      export CXX=clang++
    '';

    enableParallelBuilding = true;

    doCheck = true;
    preCheck = ''
      # Patch tests script she bang
      patchShebangs ..

      # Patch inside scripts in the yaml test files that are not catch by
      # patchShebangs utility
      find .. -type f | xargs sed -i -e 's#\(.*\)/usr/bin/env\(.*\)#\1${pkgs.coreutils}/bin/env\2#'

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
  });
}
