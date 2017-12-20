{ dmpkgs ? import ../. {} }:
with dmpkgs;
dmpkgs.stdenv.mkDerivation {
  name = "evalys";
  buildInputs = [ dmpkgs.python evalys ];
  }
