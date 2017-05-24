{ stdenv, fetchurl, ocaml, findlib, ocamlbuild, opam,  ppx_deriving, topkg, cppo}:

stdenv.mkDerivation rec {
	name = "ppx_deriving_protobuf-${version}";
	version = "1.0";
	src = fetchurl {
		url = "https://github.com/whitequark/ppx_deriving_protobuf/archive/v2.5.tar.gz";
		sha256 = "05rimrgd1g2qjd292x1287k5nvl7fq9670llal01y01fvcnh5zji";
	};

	unpackCmd = "tar xjf $src";

	buildInputs = [ ocaml findlib ocamlbuild topkg opam ];

        propagatedBuildInputs = [ ppx_deriving cppo ];

        #buildPhase = "ocaml -I ${findlib}/lib/ocaml/${ocaml.version}/site-lib/ pkg/build.ml build=true native=true native-dynlink=true lwt=false ounit=false";

        inherit (topkg) installPhase;

        #installPhase = "opam-installer -i --prefix=$out --libdir=$OCAMLFIND_DESTDIR";
        #installPhase = "ocaml setup.ml --install";

	meta = {
		license = stdenv.lib.licenses.isc;
		homepage = https://github.com/freuk/obandit;
		description = "OCaml module for multi-armed bandits";
		inherit (ocaml.meta) platforms;
	};
}
