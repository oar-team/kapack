{ stdenv }:

stdenv.mkDerivation rec {
  name = "loguru-${version}";
  version = "1.8.0";

  src = fetchTarball "https://github.com/emilk/loguru/archive/v${version}.tar.gz";

  installPhase = ''
    mkdir -p $out/include
    cp ./loguru.hpp $out/include/
  '';

  meta = with stdenv.lib; {
    description = "A header-only C++ logging library";
    homepage = https://github.com/emilk/loguru;
    platforms = platforms.x86_64;
    license = licenses.publicDomain;
  };
}
