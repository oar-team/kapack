{ stdenv,  zlib, openmpi, libxml2, clang  }:

stdenv.mkDerivation rec {
  name = "calibration";
  version = "git";

  src = fetchGit {
    url = "https://github.com/Ezibenroc/platform-calibration.git";
    rev = "8021f22842268471d20e34848a470b5bb0e844d1";
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
