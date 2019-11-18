{ pkgs, stdenv, fetchgit, linuxHeaders, powercap, python37 } :
stdenv.mkDerivation rec {
  name = "mojitos";
  src = fetchgit {
    url = "https://git.renater.fr/anonscm/git/mojitos/mojitos.git";
    rev = "854b0ce1c6442b248491373b12ea991816031bc3";
    sha256 = "sha256:1v1sapqbr07p8d32r1jg4c2yvfaxy89lw5c1njqvsnqvhdyhvhaw";
  };

  buildInputs = [
    linuxHeaders
    powercap
    (python37.withPackages(ps: with ps; [ ]))
  ];

  preConfigure = ''
    ls -l
    patchShebangs ./counters_option.py
    substituteInPlace  counters_option.py --replace /usr/include "${linuxHeaders}/include"
    cat counters_option.py
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp mojitos $out/bin
  '';

  meta = with stdenv.lib; {
    broken = false;
    longDescription = ''An open source system, energy and network monitoring tools at the O/S level'';
    homepage = "https://sourcesup.renater.fr/www/mojitos/";
    description = "An open source system, energy and network monitoring tools at the O/S level";
    license = licenses.gpl3;
    platforms = [ "x86_64-linux" ];
  };
}
