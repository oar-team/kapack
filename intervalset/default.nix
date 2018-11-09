{ stdenv, fetchgit, meson, ninja, pkgconfig, boost, gtest }:

stdenv.mkDerivation rec {
  version = "1.1.0";
  name = "intervalset-${version}";

  src = fetchgit {
    url = "https://framagit.org/batsim/intervalset.git";
    rev = "v${version}";
    sha256 = "0kksrr1l9gv7fg6rdjz39ph9l6smy74jsahyaj6pmpi1kzs33qva";
  };

  nativeBuildInputs = [ meson ninja pkgconfig ];
  buildInputs = [ boost gtest ];

  meta = with stdenv.lib; {
    description = "C++ library to manage sets of integral closed intervals";
    homepage = https://framagit.org/batsim/intervalset;
    platforms = platforms.x86_64;
    license = licenses.lgpl3;
  };
}
