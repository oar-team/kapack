{ pkgs, stdenv, fetchgit, openmpi, automake, clang, openblas, ninja, simgrid }:

stdenv.mkDerivation rec {
  name = "gemmpi-${version}";
  version = "dev";

  src = fetchgit {
    url = "https://gitlab.inria.fr/adfaure/gemmpi";
    sha256 = "0ym4bpxpiamipc3jcychrs071vj0yd3z61pqxxi4kikskmivslmr";
  };

  nativeBuildInputs = [ clang openblas ninja ];

  buildInputs = [ openmpi simgrid ];

  buildPhase = ''
    mpicc --version
    mpirun --version
    ninja
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -r gemmpi   $out/bin/gemmpi
    cp -r gemsmpi  $out/bin/gemsmpi
  '';

  meta = with stdenv.lib; {
    longDescription = ''
      Performs distributed pdgemm, the algorithm is the direct apadtation of the outer product
      discribed in Parallel Algorithms (Chapman & Hall/CRC Numerical Analysis and Scientific Computing Series).
    '';
    description = ''
      Matrix multiplication benchmark on MPI.
    '';
    homepage = "https://gitlab.inria.fr/adfaure/gemmpi";
    license = licenses.gpl3;
    platforms = platforms.unix;
    broken = false;
  };

}
