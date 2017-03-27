{ dmpkgs ? import ../. {} }:
with dmpkgs;
dmpkgs.stdenv.mkDerivation {
  name = "evalys";
  buildInputs = [ python3 evalys ];
  }
