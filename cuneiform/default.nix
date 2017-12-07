{ stdenv, fetchurl, erlang, ... }:

stdenv.mkDerivation rec {
	name = "cuneiform";

  src = fetchurl {
    sha256 = "10q7y64qnspvhxldaq5lnk3a6mncirrp8vkp3zdcc776x33bz65i";
    url = "https://github.com/joergen7/cuneiform/releases/download/2.2.1-release/cuneiform";
  };

  buildPhase = ''
  mkdir -p $out/bin
  cp cuneiform $out/bin
  chmod u+x $out/bin/cuneiform
  '';

	buildInputs = [ erlang ];
}
