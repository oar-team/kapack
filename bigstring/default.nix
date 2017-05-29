{ stdenv, fetchurl, ocaml, findlib, ocamlbuild, opam }:

stdenv.mkDerivation rec {
	name = "bigstring-${version}";
	version = "0.1.1";
	src = fetchurl {
		url = "https://github.com/c-cube/ocaml-bigstring/archive/${version}.tar.gz";
		sha256 = "09rbky1x754kmgil8bkpqw91sp3g3019gq01hvjg8nqxf48av7fh";
	};

	#unpackCmd = "tar xjf $src";

	buildInputs = [ ocaml findlib ocamlbuild  opam ];

  #propagatedBuildInputs = [ ];
  #ocamlfind install bigstring META $(TO_INSTALL)
  #installPhase = ''
    #make PREFIX=$out install
  #'';
  installPhase = ''
    mkdir -p $out/lib/ocaml/4.02.3/site-lib/bigstring; 
    make install
  '';

	#inherit (topkg) buildPhase installPhase;
}
