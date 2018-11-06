{ stdenv,  zlib, openmpi, fetchgit, libxml2, clang  }:

stdenv.mkDerivation rec {
  name = "calibration";
  version = "git";

  src = fetchgit {
    url = "https://gitlab.inria.fr/simgrid/platform-calibration.git";
    sha256 = "141q2irziaf02rvxgmgb3692ixx0yq9i9b49mcld7r2dqp3x2pn6";
  };

  # patches = [ ./libxml.diff ];
  nativeBuildInputs = [ zlib openmpi libxml2.dev clang ];

  configurePhase = ''

  '';

  buildPhase = ''
    cd src/calibration && make LDIR=-I${libxml2.dev}/include/libxml2/
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv calibrate $out/bin
  '';

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = ''
    '';
    homepage    = "https://www.nas.nasa.gov/publications/npb.html";
    platforms   = platforms.unix;
  };
}
