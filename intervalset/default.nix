{ stdenv, fetchgit, cmake, boost, gtest }:

stdenv.mkDerivation rec {
  version = "1.0.0";
  name = "intervalset-${version}";

  src = fetchgit {
    url = "https://framagit.org/batsim/intervalset.git";
    rev = "v${version}";
    sha256 = "05nzqvmhi9dhqs0yzw7g6ybkdxkp74hnc53w4w4aa22a65dji637";
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
