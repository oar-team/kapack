{ stdenv, fetchurl, erlang, ... }:

stdenv.mkDerivation rec {
	name = "cuneiformlang";

  src = fetchurl {
    executable = true;
    sha256 = "1ars3yysi1n8xcxa2rdl6l04hmd89f0yink0y2c7ng3arllbcdya";
    url = "https://github.com/joergen7/cuneiform/releases/download/2.2.1-release/cuneiform";
  };

  phases = [ "installPhase" "fixupPhase" ];

  installPhase = ''
  mkdir -p $out/bin
  cp $src $out/bin/cuneiform
  '';

	buildInputs = [ erlang ];
	propagatedBuildInputs = [ erlang ];
}
