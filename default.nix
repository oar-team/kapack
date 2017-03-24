{pkgs ? import <nixpkgs> {} }:
let
  callPackage = pkgs.lib.callPackageWith (pkgs // pkgs.xlibs // self);
  self = {
    simgrid_batsim = callPackage ./simgrid/batsim.nix { };
    batsim = callPackage ./batsim { };
    redox = callPackage ./redox { };
    rapidjson = callPackage ./rapidjson { };
    obandit = pkgs.ocamlPackages.callPackage ./obandit { };
    #ocs = pkgs.ocamlPackages.callPackage ./ocs { };
  };
in
self
