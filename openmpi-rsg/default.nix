{ stdenv, openmpi, openmpi_rsg_plugins, rsync }:

stdenv.mkDerivation rec {
  name = "openmpi-rsg";

  # This package has no source. It's just a mix of OpenMPI + plugins
  phases = [ "buildPhase" "installPhase" ];

  nativeBuildInputs = [ rsync ];
  buildInputs = [ openmpi openmpi_rsg_plugins ];

  buildPhase = ''
    mkdir -p $TMP/out/lib/openmpi

    echo "Copy OpenMPI files into the build directory"
    rsync -a ${openmpi}/* $TMP/out --exclude ompi --exclude orte --exclude opal

    echo "Copy plugins into the build directory"
    rsync -a ${openmpi_rsg_plugins}/lib/* $TMP/out/lib
  '';

  installPhase = ''
    echo "Move the temporary directory into the nix store"
    rsync -a $TMP/out/* $out
  '';

  meta = with stdenv.lib; {
    description = "OpenMPI with Remote SimGrid plugins.";
    homepage = "none";
    longDescription = description;
    license = licenses.bsd3;
    platforms   = platforms.unix;
    broken = false;
  };
}
