{ stdenv, fetchFromGitHub, cmake, hiredis, libev }:

stdenv.mkDerivation rec {
  name = "redox";

  src = fetchFromGitHub {
    repo = "redox";
    owner = "hmartiro";
    rev = "520fe0c2bfb99c1a10796f15f1d71c26b0b64db8";
    sha256= "1jx1gj72vwgk3vxh0645wax3i30wp22zdgb7la29pcg790jnhmkf";
  };

  nativeBuildInputs = [ cmake ];

  buildInputs = [ hiredis libev ];

  meta = with stdenv.lib; {
    description = "Modern, asynchronous, and wicked fast C++11 client for Redis";
    homepage    = https://github.com/hmartiro/redox;
    license     = licenses.asl20;
    platforms   = platforms.unix;

    longDescription = ''
      A fast JSON parser/generator for C++ with both SAX/DOM style API
    '';
  };
}
