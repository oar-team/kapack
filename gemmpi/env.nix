{ pkgs, openmpi, gemmpi }:
pkgs.buildEnv {
  name = "gemmpiEnv";
  paths = with pkgs; [
    openmpi
    gemmpi
  ];
}
