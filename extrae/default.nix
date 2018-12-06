{ stdenv, openmpi, gfortran, papi, libxml2, libbfd, libiberty, autoconf, automake, libtool, findutils}:

stdenv.mkDerivation rec {
  name = "extrae-${version}";
  version = "3.6.1";

  #src = fetchTarball https://github.com/oar-team/batsim-env-recipes/raw/master/steps/data/extrae-3.2.1.tar.bz2;
  src = fetchGit {
    url = "https://github.com/bsc-performance-tools/extrae.git";
    rev = "20346717547e2339968c82746d55a8f0600f8360";
    ref = "master";
  };
  nativeBuildInputs = [openmpi  gfortran autoconf automake libtool findutils];

  buildInputs = [papi libxml2 libbfd libiberty ];

  enableParallelBuilding = true;

  hardeningDisable = ["all"];

  preConfigure = ''
    echo Generate configure and makefiles...
    libtoolize \
    && autoheader \
    && aclocal \
    && automake --add-missing \
    && autoconf

    # Fix path because they are not in binutils home
    # sed -i 's#^\([ \t]*\)LIBERTY_HOME=.*#\1LIBERTY_HOME=${libiberty}#' configure
    # sed -i 's#^\([ \t]*\)BFD_HOME=.*#\1BFD_HOME=${libiberty}#' configure

    # fix call to find
    sed -i 's#/usr/bin/find#find#' ./substitute-all
    '';

  configureFlags = ''
    --with-mpi=${openmpi}
    --without-unwind
    --with-papi=${papi}
    --without-binutils
    --without-dyninst
    --disable-openmp
    '';

  # Add debug flags
  #dontStrip = true;

  meta = with stdenv.lib; {
    description = ''A dynamic instrumentation package to trace programs
      compiled and run with the shared memory model (like OpenMP and pthreads),
      the message passing (MPI) programming model or both programming models
      (different MPI processes using OpenMP or pthreads within each MPI
      process). **Extrae** generates trace files that can be later visualized
      with **Paraver**.
      '';
    homepage    = "https://tools.bsc.es/extrae";
    platforms   = platforms.unix;
  };
}
