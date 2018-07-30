{ clangStdenv, fetchurl, gfortran, perl, libnl, rdma-core, zlib

# Needed by autoconf.pl to generate configure
, autoconf, libtool, automake, flex

# Actually, rev from util-linux is desired, not eject at all
, eject

# Enable the Sun Grid Engine bindings
, enableSGE ? false

# Pass PATH/LD_LIBRARY_PATH to point to current mpirun by default
, enablePrefix ? false
}:

let
  majorVersion = "3.1";
  minorVersion = "1";

in clangStdenv.mkDerivation rec {
  name = "openmpi-3.1.1";

  src = fetchurl {
    url = "http://www.open-mpi.org/software/ompi/v3.1/downloads/openmpi-3.1.1.tar.gz";
    sha256 = "1ki5pxpjax0j1n52pmng1lb4zvh436rff8s4b706zjd05bnvfsw4";
  };

  postPatch = ''
    patchShebangs ./
  '';

  autoconfInputs = [ autoconf libtool automake flex ];

  buildInputs = with clangStdenv; [ gfortran zlib ]
    ++ autoconfInputs
    ++ lib.optional isLinux libnl
    ++ lib.optional (isLinux || isFreeBSD) rdma-core;

  nativeBuildInputs = [ perl eject ];

  configureFlags = with clangStdenv; []
    ++ lib.optional isLinux  "--with-libnl=${libnl.dev}"
    ++ lib.optional enableSGE "--with-sge"
    ++ lib.optional enablePrefix "--enable-mpirun-prefix-by-default"
    ;

  enableParallelBuilding = true;

  # Patch shebangs of all files
  prePatch = ''
    patchShebangs .
  '';

  # Force the regeneration of configure
  preConfigure = ''
    ./autogen.pl --force
  '';

  # Keep generated sources so that plugins can be added
  postInstall = ''
    rm -f $out/lib/*.la

    ###
    # Retrieve some source files, so that plugins can be compiled
    ###

    # 1. Create all directories containing .h files
    find ompi orte opal -name '*.h' | \
      rev | cut -d'/' -f2- | rev | sort -u | \
      sed -E 's/(.*)/mkdir -p $out\/\1/' | \
      bash -eux

    # 2. Copy all .h files into $out at their initial position
    find ompi orte opal -name '*.h' | \
      sed -E 'sW(.*)Wcp \1 $out/\1W' | \
      bash -eux
   '';

  doCheck = true;

  meta = with clangStdenv.lib; {
    homepage = http://www.open-mpi.org/;
    description = "Open source MPI-3 implementation";
    longDescription = "The Open MPI Project is an open source MPI-3 implementation that is developed and maintained by a consortium of academic, research, and industry partners. Open MPI is therefore able to combine the expertise, technologies, and resources from all across the High Performance Computing community in order to build the best MPI library available. Open MPI offers advantages for system and software vendors, application developers and computer science researchers.";
    maintainers = with maintainers; [ markuskowa ];
    license = licenses.bsd3;
    platforms = platforms.unix;
  };
}
