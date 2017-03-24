{ stdenv, fetchurl, ocaml, findlib, ocamlbuild, opam, ocaml_batteries, topkg }:

stdenv.mkDerivation rec {
	name = "obandit-${version}";
	version = "0.2.1";
	src = fetchurl {
		url = "http://freux.fr/obandit/releases/obandit-${version}.tbz";
		sha256 = "168ffhqc1sqn9aphgdh7bfsy6i5i7f3fal3nmqhfcwbm0h5779zm";
	};

	unpackCmd = "tar xjf $src";

	buildInputs = [ ocaml findlib ocamlbuild topkg opam ];

  propagatedBuildInputs = [ ocaml_batteries ];

	inherit (topkg) buildPhase installPhase;

	meta = {
		license = stdenv.lib.licenses.isc;
		homepage = http://erratique.ch/software/rresult;
		description = "Result value combinators for OCaml";
		inherit (ocaml.meta) platforms;
	};
}
