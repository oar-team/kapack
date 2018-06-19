{ stdenv, fetchgit, cmake, simgrid_remotesg, remote_simgrid,
  boost, cppzmq, zeromq, thrift, glibcLocales }:

stdenv.mkDerivation rec {
  name = "openmpi-rsg-plugins-${version}";
  version = "unreleased";

  src = fetchgit {
    rev = "c173f6cc7a1274e789bd620393a1d75a5640c621";
    url = "https://gitlab.inria.fr/mpoquet/openmpi-rsg-plugins.git";
    sha256 = "07n0vc0xpxlnb36qfn439iy475nl7g19pqfx4r42v35f1cl1kcm0";
  };

  nativeBuildInputs = [ simgrid_remotesg boost zeromq cmake thrift remote_simgrid];
  buildInputs = [ glibcLocales ];

  # Not expected to compile yet
  cmakeFlags = ["-DCMAKE_BUILD_TYPE=Debug"];

  # Environment variables used by cmake (convenient for shell)
  RSG_INSTALL_PATH = "${remote_simgrid}";
  SimGrid_PATH = "${simgrid_remotesg}";

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "OpenMPI plugins to use Remote SimGrid as network backend.";
    homepage    = "https://gitlab.inria.fr/mpoquet/openmpi-rsg-plugins";
    platforms   = platforms.unix;
  };
}
