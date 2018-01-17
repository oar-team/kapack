{ stdenv, fetchurl, perl }:

stdenv.mkDerivation rec {
  name = "cgvg-${version}";
  version = "1.6.3";

  src = fetchurl {
    url = "http://uzix.org/cgvg/cgvg-${version}.tar.gz";
    sha256 = "1wqjk9jg9fjjvpprng56k02fgmnyh43hqvyqm10qi66cmd0zayfq";
  };

  buildInputs = [ perl ];

  meta = with stdenv.lib; {
    description = "Commandline tools for searching and browsing sourcecode";
    homepage    = http://uzix.org/cgvg.html;
    license     = licenses.gpl2;
    platforms   = platforms.unix;
  };
}


