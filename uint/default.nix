{ stdenv, fetchurl, ocaml, findlib, ocamlbuild, opam  }:

stdenv.mkDerivation rec {
	name = "uint-${version}";
	version = "1.2.0";
	src = fetchurl {
		url = "https://github.com/andrenth/ocaml-uint/archive/1.2.0.tar.gz";
		sha256 = "1376ms42jj0i2g8l991h02d9w1sv6x2p0b3sn9s1r106niybprgw";
	};

  configurePhase = '' ocaml setup.ml -configure --prefix $out '';
  buildPhase = "ocaml setup.ml -build";
  installPhase = "ocaml setup.ml -install";
  createFindlibDestdir = true;

	buildInputs = [ ocaml findlib ocamlbuild  opam ];
}
