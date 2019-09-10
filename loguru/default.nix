{ stdenv }:

stdenv.mkDerivation rec {
  name = "loguru-${version}";
  version = "2.0.0";

  src = fetchTarball "https://github.com/emilk/loguru/archive/v${version}.tar.gz";

  buildPhase = ''
    $CXX -std=c++11 -o libloguru.so -shared -pthread -fPIC loguru.cpp
  '';

  installPhase = ''
    mkdir -p $out/lib
    cp libloguru.so $out/lib/

    mkdir -p $out/include
    cp ./loguru.hpp $out/include/

    mkdir -p $out/lib/pkgconfig
    cat <<EOF >>$out/lib/pkgconfig/loguru.pc
prefix=$out
libdir=$out/lib
includedir=$out/include

Name: loguru
Description: A lightweight and flexible C++ logging library.
Version: 2.0.0
Cflags: -I$out/include
EOF
  '';

  meta = with stdenv.lib; {
    description = "A header-only C++ logging library";
    longDescription = "A lightweight and flexible C++ logging library.";
    homepage = https://github.com/emilk/loguru;
    platforms = platforms.x86_64;
    license = licenses.publicDomain;
    broken = false;
  };
}
