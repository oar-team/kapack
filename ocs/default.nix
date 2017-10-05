{ stdenv, fetchgit, ocaml, findlib, ocamlbuild, opam, ocaml_batteries, topkg, obandit, cmdliner, ppx_sexp_conv, sexplib, ppx_deriving, ppx_deriving_protobuf, zmq, pkgconfig, oocvx}:

stdenv.mkDerivation rec {
  name = "ocs-${version}";
  version = "git";

  src = fetchgit {
    url= "https://gitlab.inria.fr/vreis/ocst.git";
    rev= "1b09dfe045174a34b9b0feabd64bab9271777b69";
    sha256= "1p9fspcn1llgq3prlyxpdpsj8vljg22ijnxk23qb2y1bx56yfxmq";
  };


  nativeBuildInputs = [ pkgconfig ];

  buildInputs = [ ocaml findlib ocamlbuild topkg opam ];

  propagatedBuildInputs = [
    ocaml_batteries 
    obandit 
    oocvx
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
