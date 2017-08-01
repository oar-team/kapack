{ stdenv, fetchFromGitHub, ocaml, findlib, ocamlbuild, opam, ocaml_batteries, sexplib, csv, cmdliner, topkg}:

stdenv.mkDerivation rec {
  name = "oocvx-${version}";
  version = "git";

  src = fetchFromGitHub {
    owner = "freuk";
    repo = "oocvx";
    rev = "d302906db464f86d118558c5239e8c38fc754bef";
    sha256 = "1cv6ykbyj8f8b8zhj6zasdjric3lzy9kc07z10brs5jq8ik4hnrs";
  };

  unpackCmd = "tar xjf $src";

  buildInputs = [ ocaml findlib ocamlbuild topkg opam  ];

  propagatedBuildInputs = [ ocaml_batteries sexplib cmdliner csv];

  inherit (topkg) buildPhase installPhase;

  meta = {
    license = stdenv.lib.licenses.isc;
    #homepage = https://github.com/freuk/oocvx;
    description = "OCaml online convex optimization";
    inherit (ocaml.meta) platforms;
  };
}
