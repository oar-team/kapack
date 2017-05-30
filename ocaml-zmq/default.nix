{ stdenv, fetchurl, ocaml, findlib, ocamlbuild, opam, stdint, zeromq }:

stdenv.mkDerivation rec {
	name = "ocaml-zmq-${version}";
	version = "4.0-8";
	src = fetchurl {
		url = "https://github.com/issuu/ocaml-zmq/archive/${version}.tar.gz";
		sha256 = "10j6jrfinlwg1sph4hraidccznf29rvkivjx1ayglh5r5x9a0cbw";
	};

  configurePhase = ''ocaml setup.ml -configure --prefix $out '';
  buildPhase = "ocaml setup.ml -build";
  installPhase = "ocaml setup.ml -install";
  createFindlibDestdir = true;

	buildInputs = [ ocaml findlib ocamlbuild opam stdint zeromq ];

	propagatedBuildInputs = [ stdint zeromq ];
}
