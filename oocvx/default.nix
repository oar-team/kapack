{ stdenv, fetchurl, ocaml, findlib, ocamlbuild, opam, ocaml_batteries, sexplib, csv, topkg }:

stdenv.mkDerivation rec {
	name = "oocvx-${version}";
	version = "0.0.1";
	src = fetchurl {
		url = "https://github.com/freuk/oocvx/archive/v${version}-zenodo.tar.gz";
		sha256 = "e1a8l4kvv811vy11gjj9nvz1px7s4zxrr3zi53zblvkibq56zzl7s";
	};

	unpackCmd = "tar xjf $src";

	buildInputs = [ ocaml findlib ocamlbuild topkg opam  ];

  propagatedBuildInputs = [ ocaml_batteries sexplib csv ];

	inherit (topkg) buildPhase installPhase;

	meta = {
		license = stdenv.lib.licenses.isc;
		#homepage = https://github.com/freuk/oocvx;
		description = "OCaml online convex optimization";
		inherit (ocaml.meta) platforms;
	};
}
