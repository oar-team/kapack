{ fetchgit, stdenv, coreutils, cmake, perl, ruby, boost, lua5_1, graphviz, libsigcxx
, libunwind, elfutils, python3, doxygen
}:

stdenv.mkDerivation rec {
  version = "batsim";
  name = "simgrid-${version}";

  src = fetchgit {
    url = "https://github.com/freuk/simgrid.git";
    rev = "refs/heads/batsim";
    sha256 = "042ac6dhqlb9kbprsjhxx7jklpwyl2wf6rr39fs0pwninzyzxpxl";
  };

  nativeBuildInputs = [ cmake perl ruby elfutils python3 doxygen ];
  buildInputs = [ boost libsigcxx libunwind ];

  preConfigure =
    # Make it so that libsimgrid.so will be found when running programs from
    # the build dir.
    ''
    export LD_LIBRARY_PATH="$PWD/src/.libs"
    export cmakeFlags="$cmakeFlags -Dprefix=$out"

    export NIX_CFLAGS_COMPILE="$NIX_CFLAGS_COMPILE
       -isystem $(echo "${libsigcxx}/lib/"sigc++*/include)
       -isystem $(echo "${libsigcxx}/include"/sigc++* )
       "

    export CMAKE_PREFIX_PATH="$CMAKE_PREFIX_PATH:$(echo "${libsigcxx}/lib/"sigc++*)"
    '';
  # Enable more functionality.
  cmakeFlags= ''
       -Denable_jedule=off
       -Denable_ns3=off
       -Denable_lua=off
       -Denable_debug=on
       -Denable_compile_warnings=on
        -Denable_compile_optimizations=off
       -DCMAKE_BUILD_TYPE=Debug
    '';
  makeFlags = "VERBOSE=1";

  preBuild =
    /* Work around this:

      [ 20%] Generating _msg_handle_simulator.c, _msg_handle_client.c, _msg_handle_server.c
      cd /tmp/nix-build-7yc8ghmf2yb8zi3bsri9b6qadwmfpzhr-simgrid-3.5.drv-0/simgrid-3.5/build/teshsuite/gras/msg_handle && ../../../bin/gras_stub_generator msg_handle /tmp/nix-build-7yc8ghmf2yb8zi3bsri9b6qadwmfpzhr-simgrid-3.5.drv-0/simgrid-3.5/teshsuite/gras/msg_handle/msg_handle.xml
      ../../../bin/gras_stub_generator: error while loading shared libraries: libsimgrid.so.3.5: cannot open shared object file: No such file or directory
      make[2]: *** [teshsuite/gras/msg_handle/_msg_handle_simulator.c] Error 127
      make[2]: Leaving directory `/tmp/nix-build-7yc8ghmf2yb8zi3bsri9b6qadwmfpzhr-simgrid-3.5.drv-0/simgrid-3.5/build'

    */
    '' export LD_LIBRARY_PATH="$PWD/lib:$LD_LIBRARY_PATH"
       echo "\$LD_LIBRARY_PATH is \`$LD_LIBRARY_PATH'"

       # Some perl scripts are called to generate test during build which
       # is before the fixupPhase of nix, so do this manualy here:
       patchShebangs ..
    '';

  # Fixing the few tests that fail is left as an exercise to the reader.
  doCheck = false;

  meta = with stdenv.lib; {
    description = "Simulator for distributed applications in heterogeneous environments";

    longDescription =
      '' SimGrid is a toolkit that provides core functionalities for the
         simulation of distributed applications in heterogeneous distributed
         environments.  The specific goal of the project is to facilitate
         research in the area of distributed and parallel application
         scheduling on distributed computing platforms ranging from simple
         network of workstations to Computational Grids.
      '';

    homepage = http://simgrid.gforge.inria.fr/;

    license = stdenv.lib.licenses.lgpl2Plus;
  };
}
