{ stdenv, fetchurl, ocaml, findlib, ocamlbuild, opam, cstruct, ctypes, ppx_deriving,
topkg, ipaddr, nanomsg, containers, pkgconfig, bigstring}:

stdenv.mkDerivation rec {
  name = "onanomsg-${version}";
  version = "1.0";
  src = fetchurl {
    url = "https://github.com/rgrinberg/onanomsg/archive/${version}.tar.gz";
    sha256 = "12qzym8vx81gdd4cjypcfspr44bl9gvb6r0nw1f6ab4ciyczhcyi";
  };

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ ocaml findlib ocamlbuild topkg opam bigstring ];

  propagatedBuildInputs = [ cstruct ctypes ppx_deriving ipaddr nanomsg containers ];

  buildPhase = "ocaml pkg/build.ml build=true native=true native-dynlink=true lwt=false ounit=false";

  patches = [ ./dlopen.patch ];

  preConfigure = ''
    substituteInPlace lib/nanomsg_ctypes.ml \
      --replace '@NIXNANOMSGLIB@' '${nanomsg}/lib/libnanomsg.so'
  '';

  inherit (topkg) installPhase;
}
