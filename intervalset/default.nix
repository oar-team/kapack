{ stdenv, fetchgit, meson, ninja, pkgconfig, boost, gtest }:

stdenv.mkDerivation rec {
  version = "1.2.0";
  name = "intervalset-${version}";

  src = fetchgit {
    url = "https://framagit.org/batsim/intervalset.git";
    rev = "v${version}";
    sha256 = "1ayj6jjznbd0kwacz6dki6yk4rxdssapmz4gd8qh1yq1z1qbjqgs";
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
