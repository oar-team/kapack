{ stdenv, fetchgit, cmake, boost }:

stdenv.mkDerivation rec {
  version = "unstable";
  name = "intervalset-${version}";

  src = fetchgit {
    url = "https://framagit.org/batsim/intervalset.git";
    rev = "99bc8e3e06372b3dd8c93db5fc472f9306459f91";
    sha256 = "1lwa2p65yl9jbvvcb0jpg9pdnci5grlwwrl92iczr0wwmshh6sny";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ boost ];

  meta = with stdenv.lib; {
    description = "C++ library to manage sets of integral closed intervals";
    homepage = https://framagit.org/batsim/intervalset;
    platforms = platforms.x86_64;
    license = licenses.lgpl3;
  };
}
