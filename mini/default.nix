{ stdenv, openmpi, papi }:

stdenv.mkDerivation rec {
  name = "mini";
  version = "1.0-0f70b12";

  src = fetchGit {
    url = "https://github.com/gmarkomanolis/mini.git";
    rev = "0f70b12f8551244711ec4865022e685e4e3ad456";
    ref = "master";
  };

  buildInputs = [ openmpi papi ];

  hardeningDisable = ["all"];

  buildPhase = ''
    gcc -Wno-error=format-security -shared -fPIC -c -I${openmpi}/include/ mini.c
    gcc -fPIC -shared -o libmini.so mini.o
  '';

  installPhase = ''
    mkdir -p $out/lib
    cp libmini.so $out/lib
  '';

  meta = with stdenv.lib; {
    description = '' MINI is a tracing library that provides minimal
      instrumentation of MPI applications. Its purpose is to minimize the
      instrumentation overhead and provide the executed instructions for all
      the computation phases and detailed communication pattern between the MPI
      processes.
      '';
    homepage    = "https://github.com/gmarkomanolis/mini";
    platforms   = platforms.unix;
  };
}
