{ stdenv, fetchFromGitHub, ocaml, findlib, ocamlbuild, opam, topkg, batteries }:

stdenv.mkDerivation rec {
	name = "zymake";

  src = fetchFromGitHub {
    owner = "freuk";
    repo = "zymake";
    rev = "e2ee37ed8d729bf31b2cbe00bcb977c451c656e2";
    sha256 = "1djndij7d2lary1m20wz6kwxz272mg21h8bn2mm238ijyz38g57j";
  };

	#unpackCmd = "tar xjf $src";

	buildInputs = [ ocaml findlib ocamlbuild topkg opam batteries ];

	inherit (topkg) buildPhase installPhase;

	meta = {
		license = stdenv.lib.licenses.isc;
		homepage = http://www-personal.umich.edu/~ebreck/code/zymake/;
		description = "Zymake workflow system.";
		inherit (ocaml.meta) platforms;
	};
}
