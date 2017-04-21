{ stdenv, fetchFromGitHub, ocaml, findlib, ocamlbuild, opam, ocaml_batteries, topkg, obandit, cmdliner }:


stdenv.mkDerivation rec {
	name = "ocs-${version}";
	version = "0.2";

  src = fetchFromGitHub {
    owner = "freuk";
    repo = "ocst";
    rev = "9872b40a4c0d7213b69a2b6c8c555b44bd7ca644";
    sha256 = "1l40w41g3zjjjml84brnbr1ml7mzs4vx41viwmpyivn05ah7nykl";
  };

	unpackCmd = "tar xjf $src";

	buildInputs = [ ocaml findlib ocamlbuild topkg opam ];

  propagatedBuildInputs = [ ocaml_batteries obandit cmdliner ];

  inherit (topkg) buildPhase installPhase;

	meta = {
		license = stdenv.lib.licenses.isc;
		description = "Ocabl backfilling simulator.";
		inherit (ocaml.meta) platforms;
	};
}
