{ stdenv, fetchurl, ocaml, findlib, ocamlbuild, opam  }:

stdenv.mkDerivation rec {
	name = "stdint-${version}";
	version = "0.3.0";
	src = fetchurl {
		url = "https://github.com/andrenth/ocaml-stdint/archive/${version}.tar.gz";
		sha256 = "19mvagz19w6yk6mf750prraw28xjxz8ki9k4k57jdy02y77h7z88";
	};

  configurePhase = '' ocaml setup.ml -configure --prefix $out '';
  buildPhase = "ocaml setup.ml -build";
  installPhase = "ocaml setup.ml -install";
  createFindlibDestdir = true;

	buildInputs = [ ocaml findlib ocamlbuild  opam ];
}
