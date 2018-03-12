{ stdenv, fetchurl, cmake, simgrid_remotesg, boost, cppzmq, zeromq, thrift }:

stdenv.mkDerivation rec {
  name = "remote-simgrid-${version}";
  version = "0.1.0";

  src = fetchurl {
    url = "https://codeload.github.com/simgrid/remote-simgrid/tar.gz/v${version}";
    sha256 = "1q05mbnwswiwi7ibd6xyljh909xplxsy7qs1v42yhny975v0jm0q";
  };

  nativeBuildInputs= [ simgrid_remotesg boost cppzmq zeromq cmake thrift ];

  cmakeFlags = ["-DCMAKE_BUILD_TYPE=Debug"
                "-Denable_warnings=ON"
                "-Dtreat_warnings_as_errors=OFF"];

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "A solution to execute your distributed application on top of SimGrid.";
    homepage    = "https://github.com/simgrid/remote-simgrid";
    platforms   = platforms.unix;
  };
}
