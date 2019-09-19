{ stdenv, fetchurl, glibc }:

stdenv.mkDerivation rec {
    pname = "gnat";
    version = "20170515-63";

    src = fetchurl {
        url = "http://mirrors.cdn.adacore.com/art/591c6d80c7a447af2deed1d7";
        sha256 = "1rjn15dq7742wgdrb09fxs6hmxhrjr6n52wznd49g8yy42nbqhmr";
    };

    #propagatedBuildInputs = [ glibc.static ];
    #buildInputs = [ glibc glibc.static ];

    unpackCmd = "tar xf $src";
    buildPhase = ''true'';

    # Yep, keep everything...
    installPhase = ''
    mkdir -p $out
    mv * $out/
    '';

    meta = with stdenv.lib; {
        description = "GNAT compiler for Ada, integrated into the GCC compiler system.";
        longDescription = ''
        GNAT is a free, high-quality, complete compiler for Ada, integrated into the GCC compiler system.
        '';
        homepage = https://www.gnu.org/software/gnat/;
        license = licenses.gpl3Plus;
        platforms = platforms.unix;
        broken = false;
    };
}
