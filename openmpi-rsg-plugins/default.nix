{ clangStdenv, fetchgit, cmake, pkgconfig, simgrid, remote_simgrid,
  boost, cppzmq, glibcLocales, openmpi, jansson, which

# Print btl logs?
, printBtlLogs ? true

# Print odls logs?
, printOdlsLogs ? true
}:

clangStdenv.mkDerivation rec {
  pname = "openmpi-rsg-plugins";
  version = "unreleased";

  src = fetchgit {
    rev = "3f451b9772d9917a9a3ac4005d220054b26d99e9";
    url = "https://gitlab.inria.fr/mpoquet/openmpi-rsg-plugins.git";
    sha256 = "1yyzdv1995lizl7n85i0d2ibkxslx4cpjkncwgkkfdkjc9fhkgqw";
  };

  nativeBuildInputs = [ boost cmake openmpi which pkgconfig ];
  buildInputs = [ glibcLocales ];
  propagatedBuildInputs = [ remote_simgrid jansson ];

  # TODO: Make sure plugins call the right RSG binaries

  # env variables used by CMake
  OMPI_SRC_PATH = "${openmpi}";
  OMPI_INSTALL_PATH = "${openmpi}";

  cmakeFlags = with clangStdenv; ["-DCMAKE_BUILD_TYPE=Debug"];

  enableParallelBuilding = true;

  meta = with clangStdenv.lib; {
    description = "OpenMPI plugins to use Remote SimGrid as network backend.";
    longDescription = description;
    homepage    = "https://gitlab.inria.fr/mpoquet/openmpi-rsg-plugins";
    platforms   = platforms.unix;
    license = licenses.lgpl3;
    broken = false;
  };
}
