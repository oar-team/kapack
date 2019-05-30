{ stdenv, fetchgit, cmake, shared ? false }:

stdenv.mkDerivation rec {
  name = "pugixml-${version}";
  version = "1.9";

  src = fetchgit {
    url = "https://github.com/mpoquet/pugixml.git";
    rev = "bfa2542f09a4e535f18e6a8ecd421105b0345e66";
    sha256 = "0ikd9acs23kbdr42bz8m4h07cmxq4j13fp10h5s7p47sfnymswmj";
  };

  nativeBuildInputs = [ cmake ];

  cmakeFlags = [ "-DBUILD_SHARED_LIBS=${if shared then "ON" else "OFF"}" ];

  preConfigure = ''
    # Enable long long support (required for filezilla)
    sed -ire '/PUGIXML_HAS_LONG_LONG/ s/^\/\///' src/pugiconfig.hpp
  '';

  meta = with stdenv.lib; {
    description = "Light-weight, simple and fast XML parser for C++ with XPath support";
    longDescription = description;
    homepage = https://pugixml.org;
    license = licenses.mit;
    broken = false;
    maintainers = with maintainers; [ pSub ];
    platforms = platforms.unix;
  };
}
