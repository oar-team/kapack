{ stdenv, fetchgit, ocaml, findlib, ocamlbuild, opam, ocaml_batteries, topkg, obandit, cmdliner, ppx_sexp_conv, sexplib, ppx_deriving, ppx_deriving_protobuf, zmq, pkgconfig }:

stdenv.mkDerivation rec {
  name = "ocs-${version}";
  version = "git";

  src = fetchgit {
    url= "https://gitlab.inria.fr/vreis/ocst.git";
    rev= "e4845babcf4c456d6bd9af8b0995e7c2039ef47d";
    sha256= "1a9418k4ldcfhwdlx4ddhma1zwx8n0i2f66rqhrb117a6ic948v6";
  };


  nativeBuildInputs = [ pkgconfig ];

  buildInputs = [ ocaml findlib ocamlbuild topkg opam ];

  propagatedBuildInputs = [
    ocaml_batteries 
    obandit 
    cmdliner
    ppx_sexp_conv
    ppx_deriving
    ppx_deriving_protobuf
    zmq
  ];

  inherit (topkg) buildPhase;

  installPhase = topkg.installPhase + ''
      ;cp _build/src/*.protoc $out/lib/
  '';

  meta = {
    license = stdenv.lib.licenses.isc;
    description = "Ocaml backfilling simulator.";
    inherit (ocaml.meta) platforms;
  };
}
