{ clangStdenv, fetchgit, cmake, simgrid, remote_simgrid,
  boost, cppzmq, glibcLocales, openmpi, jansson }:

clangStdenv.mkDerivation rec {
  name = "openmpi-rsg-plugins-${version}";
  version = "unreleased";

  src = fetchgit {
    rev = "3f451b9772d9917a9a3ac4005d220054b26d99e9";
    url = "https://gitlab.inria.fr/mpoquet/openmpi-rsg-plugins.git";
    sha256 = "1yyzdv1995lizl7n85i0d2ibkxslx4cpjkncwgkkfdkjc9fhkgqw";
  };

  nativeBuildInputs = [ remote_simgrid boost cmake jansson openmpi ];
  buildInputs = [ glibcLocales ];

  # Not expected to compile yet
  cmakeFlags = ["-DCMAKE_BUILD_TYPE=Debug"];

  # Environment variables used by cmake (convenient for shell)
  SimGrid_PATH = "${simgrid}";
  RSG_INSTALL_PATH = "${remote_simgrid}";
  OMPI_SRC_PATH = "${openmpi}";
  OMPI_INSTALL_PATH = "${openmpi}";

  installPhase = ''
    # Put all plugins into the lib/openmpi/ directory
    mkdir -p $out/lib/openmpi

    find . -name '*.so' | sed -E 'sW(.*)Wcp \1 $out/lib/openmpi/W' | bash -eux
  '';

  enableParallelBuilding = true;

  meta = with clangStdenv.lib; {
    description = "OpenMPI plugins to use Remote SimGrid as network backend.";
    homepage    = "https://gitlab.inria.fr/mpoquet/openmpi-rsg-plugins";
    platforms   = platforms.unix;
  };
}
