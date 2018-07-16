{ stdenv, fetchFromGitHub, cmake, simgrid, boost, cppzmq, zeromq, thrift, glibcLocales }:

stdenv.mkDerivation rec {
  name = "remote-simgrid-${version}";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "simgrid";
    repo = "remote-simgrid";
    rev = "a223dadbed4bc1aaa248a857c980c4367d2652b6";
    sha256 = "01vnhrjprf38v5k4wqqj3hxybsd5k9nxvpmq28kjg00jk4c7lqja";
  };

  nativeBuildInputs = [ simgrid boost cppzmq zeromq cmake thrift ];
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
    homepage    = "https://github.com/simgrid/remote-simgrid";
    platforms   = platforms.unix;
  };
}
