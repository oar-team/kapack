{ stdenv, fetchurl, openmpi, automake, gfortran, gcc, bc}:

stdenv.mkDerivation rec {
  name = "NPB-${version}";
  version = "3.1";

  src = fetchurl {
    url = "https://www.nas.nasa.gov/assets/npb/NPB3.${version}.tar.gz";
    sha256 = "0bbxfjd4rh36xydgdy5n5gn50sn2nfc73i24qn1zasfzn5wsd3ja";
  };

  nativeBuildInputs = [ openmpi automake gfortran gcc bc ];

  buildPhase = ''
  mkdir -p $out/bin
  cd NPB3.3-MPI/

  cp config/make.def{.template,}

  sed -i 's/^MPIF77.*/MPIF77 = mpif77/' config/make.def
  sed -i 's/^MPICC.*/MPICC = mpicc/' config/make.def
  sed -i 's/^FFLAGS.*/FFLAGS  = -O -mcmodel=medium/' config/make.def

  for nbproc in $(for i in $(seq 2 10); do echo "2^$i" | bc; done)
  do
    echo $nbproc
    for class in A B C D E
    do
      for bench in is ep cg mg ft bt sp lu
      do
        # Not all bench are compiling so skip the errors
        make -j $(nproc) $bench NPROCS=$nbproc CLASS=$class || echo \
        "Warning: the bench $class for $nbproc procs is not compiling"
      done
    done
  done
  '';

  installPhase = ''
    cp -r bin $out/
  '';

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = ''
    The NAS Parallel Benchmarks (NPB) are a small set of programs designed to
    help evaluate the performance of parallel supercomputers. The benchmarks
    are derived from computational fluid dynamics (CFD) applications and
    consist of five kernels and three pseudo-applications in the original
    "pencil-and-paper" specification (NPB 1). The benchmark suite has been
    extended to include new benchmarks for unstructured adaptive mesh,
    parallel I/O, multi-zone applications, and computational grids.  Problem
    sizes in NPB are predefined and indicated as different classes. Reference
    implementations of NPB are available in commonly-used programming models
    like MPI and OpenMP (NPB 2 and NPB 3)
    '';
    homepage    = "https://www.nas.nasa.gov/publications/npb.html";
    platforms   = platforms.unix;
  };
}
