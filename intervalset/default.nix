{ stdenv, fetchgit, meson, ninja, pkgconfig, boost, gtest }:

stdenv.mkDerivation rec {
  version = "1.1.0-dev";
  name = "intervalset-${version}";

  src = fetchgit {
    url = "https://framagit.org/batsim/intervalset.git";
    rev = "65a0626ad3b3a76e895540b3186dfa538fb55da5";
    sha256 = "0i152xdgvqpc64p5lkfk7rzh6b2i59dy2s98ccs9pp22919k2yff";
  };

  nativeBuildInputs = [ meson ninja gtest pkgconfig ];
  buildInputs = [ boost gtest ];

  meta = with stdenv.lib; {
    description = "C++ library to manage sets of integral closed intervals";
    homepage = https://framagit.org/batsim/intervalset;
    platforms = platforms.x86_64;
    license = licenses.lgpl3;
  };
}
