{ stdenv, fetchurl, cmake, simgrid, boost,
gmp, rapidjson, openssl, redox, hiredis, libev, cppzmq, zeromq, docopt_cpp,
pugixml
}:

stdenv.mkDerivation rec {
  name = "batsim-${version}";
  version = "2.0.0";

  src = fetchurl {
    url = "https://gitlab.inria.fr/batsim/batsim/repository/v${version}/archive.tar.gz";
    sha256 = "1r5yfj984xbzlgv5zzai2w19z174s7j52nkdzfsgfqqrzzz5g3r2";
  };

  nativeBuildInputs= [ simgrid  boost  gmp  rapidjson openssl redox
  hiredis libev cppzmq zeromq docopt_cpp pugixml cmake ];

  cmakeFlags = ["-DCMAKE_BUILD_TYPE=Debug"];

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "A batch scheduler simulator with a focus on realism that facilitates comparison.";
    homepage    = "https://github.com/oar-team/batsim";
    platforms   = platforms.unix;

    longDescription = ''
      Batsim is a Batch Scheduler Simulator that uses SimGrid as the
      platform simulator.
    '';
  };
}
