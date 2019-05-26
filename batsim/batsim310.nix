{ stdenv, fetchurl
, meson, ninja, pkgconfig
, simgrid, intervalset, boost, rapidjson, redox, hiredis, libev, zeromq,
  docopt_cpp, pugixml
}:

stdenv.mkDerivation rec {
  pname = "batsim";
  version = "3.1.0";

  src = fetchurl {
    url = "https://gitlab.inria.fr/batsim/batsim/repository/v${version}/archive.tar.gz";
    sha256 = "0aa5b3bp7khazn7gyslczxydijigshxg5xf1284v31l28iq7mzvx";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkgconfig
  ];

  buildInputs = [
    simgrid
    intervalset
    boost
    rapidjson
    redox
    hiredis
    libev
    zeromq
    docopt_cpp
    pugixml
  ];

  # mesonBuildType = "debug";
  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "A batch scheduler simulator with a focus on realism that facilitates comparison.";
    homepage    = "https://github.com/oar-team/batsim";
    platforms   = platforms.unix;

    longDescription = ''
      Batsim is a Batch Scheduler Simulator that uses SimGrid as the platform simulator.
    '';
  };
}
