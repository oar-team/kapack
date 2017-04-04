{ stdenv, fetchzip, ocaml, findlib, ocamlbuild, opam, ocaml_batteries, topkg,  cmdliner }:

stdenv.mkDerivation rec {
	name = "ocs-${version}";
	version = "0.2";

  src = fetchzip {
    url= https://zenodo.org/record/439758/files/freuk/ocst-zenodo-up.zip;
    sha256 = "1aqwzagjwf7p0v3gqnjcr3v9pfwpkgm0h5bdik4dm29fzzak5r71";
  };

	unpackCmd = "tar xjf $src";

	buildInputs = [ ocaml_batteries ocaml findlib ocamlbuild topkg opam ];

  propagatedBuildInputs = [ ocaml_batteries cmdliner ];

  inherit (topkg) buildPhase installPhase;

	meta = {
		license = stdenv.lib.licenses.isc;
		description = "Ocabl backfilling simulator.";
		inherit (ocaml.meta) platforms;
	};
}
