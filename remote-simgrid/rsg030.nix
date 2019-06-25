{ stdenv, fetchgit,
  ninja, meson, pkgconfig,
  simgrid, boost, docopt_cpp, protobuf,
}:

stdenv.mkDerivation rec {
  name = "remote-simgrid-${version}";
  version = "0.3.0-unstable";
  rev = "cbe9d73c91bcd7f4945167b7e1834a36fd881650";

  src = fetchgit {
    inherit rev;
    url = "https://github.com/simgrid/remote-simgrid";
    sha256 = "10wdlrp4ymqyljiwkzhkp7r8jrn0vmf7p7n5bwgyb8kn4p0xh8jq";
  };

  nativeBuildInputs = [ meson pkgconfig ninja ];
  buildInputs = [ simgrid docopt_cpp boost protobuf ];

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "A solution to execute your distributed application on top of SimGrid.";
    longDescription = ''
      Remote SimGrid allows to study real distributed applications by sandboxing their execution in a SimGrid simulation.
      This is done by managing a simulated world in a dedicated process (rsg_server), and by providing an API so that the distributed application processes connect to rsg_server.
      The provided API calls are blocking, which allows rsg_server to control how the processes should execute in accordance with its simulation.
    '';
    homepage = "https://framagit.org/simgrid/remote-simgrid";
    platforms = platforms.unix;
    license = licenses.lgpl3;
    broken = false;
  };
}
