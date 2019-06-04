{ pkgs, stdenv, openmpi, gemmpi, simgrid }:
pkgs.buildEnv {
  name = "gemmpiEnv";

  paths = with pkgs; [
    simgrid
    openmpi
    gemmpi
  ];

   meta = with stdenv.lib; {
    description = ''
      Experiment environment for gemmpi with Simgrid.
    '';
    longDescription = ''
      Experiment environment for gemmpi with Simgrid.
      Contains Simgrid and Mpi.
    '';
    homepage = "https://gitlab.inria.fr/adfaure/gemmpi";
    license = licenses.gpl3;
    platforms = platforms.unix;
    broken = false;
  };

}
