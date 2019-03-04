{ pkgs, stdenv, fetchgit, openmpi, automake, clang, openblas }:

stdenv.mkDerivation rec {
  name = "gemmpi-${version}";
  version = "dev";

  src = fetchgit {
    url = "https://gitlab.inria.fr/adfaure/gemmpi";
    sha256 = "1piqjcdpffr2bffmx4glc98gvvf25809h6wa41rrvd4zpp6nym7s";
  };

  nativeBuildInputs = [ clang openblas ];

  buildInputs = [ openmpi ];

  buildPhase = ''
    mpicc --version
    mpirun --version
    mpicc main.c -lopenblas -lm
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
