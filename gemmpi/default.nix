{
  stdenv, fetchgit, openmpi, automake, clang, openblas
}:

stdenv.mkDerivation rec {
  name = "gemmpi-${version}";
  version = "1";

  src = fetchgit {
    url = "https://gitlab.inria.fr/adfaure/gemmpi";
    sha256 = "1piqjcdpffr2bffmx4glc98gvvf25809h6wa41rrvd4zpp6nym7s";
  };

  nativeBuildInputs = [ clang openblas ];

  buildInputs = [ openmpi ];

  buildPhase = ''
    mpicc main.c -lopenblas
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -r a.out $out/bin/gemmpi
  '';

  meta = with stdenv.lib; {
    description = ''
      Matrix multiplication benchmark on MPI.
      The algorithm is a distributed pdgemm.
    '';
    homepage    = "https://gitlab.inria.fr/adfaure/gemmpi";
    platforms   = platforms.unix;
  };
}
