{ stdenv, fetchFromGitHub, ocaml, findlib, ocamlbuild, opam, ocaml_batteries, topkg, obandit, cmdliner, ppx_sexp_conv, sexplib, ppx_deriving, onanomsg, ppx_deriving_protobuf }:


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

  propagatedBuildInputs = [ ocaml_batteries obandit cmdliner ppx_sexp_conv ppx_deriving ppx_deriving_protobuf onanomsg ];

  inherit (topkg) buildPhase;

  installPhase = topkg.installPhase + ''
    ;cp _build/src/*.protoc $out/lib/
  '';

	meta = {
		license = stdenv.lib.licenses.isc;
		description = "Ocabl backfilling simulator.";
		inherit (ocaml.meta) platforms;
	};
}
