{ stdenv, fetchFromGitHub, cmake }:

stdenv.mkDerivation rec {
  name = "rapidjson";

  src = fetchFromGitHub {
    repo = "rapidjson";
    owner = "miloyip";
    rev = "5de06bfa37495b529dc00139f1b138a526fff27a";
    sha256 = "1m0c6s8n5858zxdlanybanly42cigxz0i111nn69nxybmiv85sm0";
  };

  nativeBuildInputs = [cmake];
  cmakeFlags = [
    "-DRAPIDJSON_BUILD_DOC=OFF"
    "-DRAPIDJSON_BUILD_EXAMPLES=OFF"
    "-DRAPIDJSON_BUILD_TESTS=OFF"
  ];

  meta = with stdenv.lib; {
    description = "A JSON parser/generator for C++";
    homepage    = http://rapidjson.org;
    license     = licenses.gpl3Plus;
    platforms   = platforms.unix;
    broken = false;

    longDescription = ''
      A fast JSON parser/generator for C++ with both SAX/DOM style API
    '';
  };
}
