{ stdenv, fetchgit, cmake, simgrid, remote_simgrid,
  boost, cppzmq, glibcLocales, openmpi, jansson, which

# Print btl logs?
, printBtlLogs ? true

# Print odls logs?
, printOdlsLogs ? true
}:

stdenv.mkDerivation rec {
  name = "openmpi-rsg-plugins-${version}";
  version = "unreleased";

  src = fetchgit {
    rev = "3f451b9772d9917a9a3ac4005d220054b26d99e9";
    url = "https://gitlab.inria.fr/mpoquet/openmpi-rsg-plugins.git";
    sha256 = "1yyzdv1995lizl7n85i0d2ibkxslx4cpjkncwgkkfdkjc9fhkgqw";
  };

  nativeBuildInputs = [ boost cmake openmpi which ];
  buildInputs = [ glibcLocales ];
  propagatedBuildInputs = [ remote_simgrid jansson ];

  # Environment variables used by cmake (convenient for shell)
  SimGrid_PATH = "${simgrid}";
  RSG_INSTALL_PATH = "${remote_simgrid}";
  OMPI_SRC_PATH = "${openmpi}";
  OMPI_INSTALL_PATH = "${openmpi}";

  # Make sure plugins call the right RSG binaries
  patchPhase = ''
    # Patch rsg_server binary calls
    sed -i -E \
      "sW(const char \* rsgserver = \")(rsg_server)(\";)W\1$(which rsg_server)\3W" \
      src/odls/rsg/odls_rsg_module.c

    # Patch rsgstat binary calls
    sed -i -E \
      "sW(const char \* rsgstat = \")(rsgstat)(\";)W\1$(which rsgstat)\3W" \
      src/odls/rsg/odls_rsg_module.c
  '';

  cmakeFlags = with stdenv; ["-DCMAKE_BUILD_TYPE=Debug"]
    ++ lib.optional printBtlLogs "-Denable_debug_btl_self=ON"
    ++ lib.optional printOdlsLogs "-Denable_debug_odls_rsg=ON"
  ;

  installPhase = ''
    # Put all plugins into the lib/openmpi/ directory
    mkdir -p $out/lib/openmpi

    find . -name '*.so' | sed -E 'sW(.*)Wcp \1 $out/lib/openmpi/W' | bash -eux
  '';

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "OpenMPI plugins to use Remote SimGrid as network backend.";
    homepage    = "https://gitlab.inria.fr/mpoquet/openmpi-rsg-plugins";
    platforms   = platforms.unix;
  };
}
