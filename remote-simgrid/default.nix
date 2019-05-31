{ stdenv, fetchgit, cmake, simgrid, boost, cppzmq, zeromq, thrift, glibcLocales }:

stdenv.mkDerivation rec {
  name = "remote-simgrid-${version}";
  version = "0.2.0";
  rev = "v${version}";

  src = fetchgit {
    inherit rev;
    url = "https://github.com/simgrid/remote-simgrid";
    sha256 = "0c77h7b4xypp7a1s5kbkp3zwi7vzzkiygkpg6i1dgjqk0gxsnhfr";
  };

  nativeBuildInputs = [ boost cmake ];
  propagatedBuildInputs = [ simgrid zeromq cppzmq thrift ];
  buildInputs = [ glibcLocales ];

  cmakeFlags = ["-DCMAKE_BUILD_TYPE=Debug"
                "-Denable_warnings=ON"
                "-Dtreat_warnings_as_errors=OFF"];

  enableParallelBuilding = true;

  doCheck = false;
  checkPhase = ''
    runHook preCheck

    # So tesh (python) does not assume files and streams are in ASCII
    export LC_ALL="en_US.UTF-8"

    ctest --output-on-failure -E 'turnon_turnoff|actor_kill_pid'

    runHook postCheck
    '';

  meta = with stdenv.lib; {
    description = "A solution to execute your distributed application on top of SimGrid.";
    longDescription = ''
      Remote SimGrid allows to study real distributed applications by sandboxing their execution in a SimGrid simulation.
      This is done by managing a simulated world in a dedicated process (rsg_server), and by providing an API so that the distributed application processes connect to rsg_server.
      The provided API calls are blocking, which allows rsg_server to control how the processes should execute in accordance with its simulation.
    '';
    homepage    = "https://github.com/simgrid/remote-simgrid";
    platforms   = platforms.unix;
    license = licenses.agpl;
    broken = false;
  };
}
