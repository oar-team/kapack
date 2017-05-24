{ stdenv, fetchurl, ocaml, findlib, ocamlbuild, opam, cstruct, ctypes, ppx_deriving,
topkg, ipaddr, nanomsg, containers}:

stdenv.mkDerivation rec {
	name = "onanomsg-${version}";
	version = "1.0";
	src = fetchurl {
		url = "https://github.com/rgrinberg/onanomsg/archive/${version}.tar.gz";
		sha256 = "12qzym8vx81gdd4cjypcfspr44bl9gvb6r0nw1f6ab4ciyczhcyi";
	};

	unpackCmd = "tar xjf $src";

	buildInputs = [ ocaml findlib ocamlbuild topkg opam ];

        propagatedBuildInputs = [ cstruct ctypes ppx_deriving ipaddr nanomsg containers];

        buildPhase = "ocaml -I ${findlib}/lib/ocaml/${ocaml.version}/site-lib/ pkg/build.ml build=true native=true native-dynlink=true lwt=false ounit=false";

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
