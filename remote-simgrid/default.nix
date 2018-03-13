{ stdenv, fetchFromGitHub, cmake, simgrid_remotesg, boost, cppzmq, zeromq, thrift, glibcLocales }:

stdenv.mkDerivation rec {
  name = "remote-simgrid-${version}";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "simgrid";
    repo = "remote-simgrid";
    rev = "v0.1.0";
    sha256 = "0vs1ggibixxl44n8923yiw62z07mg5h9kpgbg8dzwcv2p32wsj3s";
  };

  nativeBuildInputs = [ simgrid_remotesg boost cppzmq zeromq cmake thrift ];
  buildInputs = [ glibcLocales ];

  cmakeFlags = ["-DCMAKE_BUILD_TYPE=Debug"
                "-Denable_warnings=ON"
                "-Dtreat_warnings_as_errors=OFF"];

  enableParallelBuilding = true;

  doCheck = true;
  checkPhase = ''
    runHook preCheck

    # So tesh (python) does not assume files and streams are in ASCII
    export LC_ALL="en_US.UTF-8"

    ctest --output-on-failure -E 'turnon_turnoff|actor_kill_pid'

    runHook postCheck
    '';

  installPhase = ''
    # not possible for the moment
  '';

  meta = with stdenv.lib; {
    description = "A solution to execute your distributed application on top of SimGrid.";
    homepage    = "https://github.com/simgrid/remote-simgrid";
    platforms   = platforms.unix;
  };
}
