{ stdenv, fetchgit, cmake, boost, gtest }:

stdenv.mkDerivation rec {
  version = "unstable";
  name = "intervalset-${version}";

  src = fetchgit {
    url = "https://framagit.org/batsim/intervalset.git";
    rev = "0df49d34c0906beb750d2aa10b89fdd7d59c084a";
    sha256 = "01jzid21sp4yw8s4vybm7xdq3q1wv9fr2shf5hxzahlh4x8bzq0x";
  };

  preConfigure = ''
    # Always build on a clean directory
    rm -rf ./build/*

    # Enable linking to libintervalset.so (done by tests)
    export LD_LIBRARY_PATH="$PWD/build"
  '';

  nativeBuildInputs = [ cmake gtest ];
  buildInputs = [ boost ];

  meta = with stdenv.lib; {
    description = "C++ library to manage sets of integral closed intervals";
    homepage = https://framagit.org/batsim/intervalset;
    platforms = platforms.x86_64;
    license = licenses.lgpl3;
  };
}
