{pkgs ? import <nixpkgs> {} }:
let
  callPackage = pkgs.lib.callPackageWith (pkgs // pkgs.xlibs // self);
  #ocamlCallPackage = pkgs.ocamlPackages.callPackageWith (pkgs // pkgs.xlibs // self);
  self = rec {
    simgrid_batsim = callPackage ./simgrid/batsim.nix { };
    batsim = callPackage ./batsim { };
    redox = callPackage ./redox { };
    rapidjson = callPackage ./rapidjson { };
    interval_set = callPackage ./interval-set { };
    evalys = callPackage ./evalys { inherit interval_set; };
    obandit = pkgs.ocamlPackages.callPackage ./obandit { };
    zymake = pkgs.ocamlPackages.callPackage ./zymake { };
    ocs = pkgs.ocamlPackages.callPackage ./ocs { inherit obandit; };
    evalysEnv = pkgs.stdenv.mkDerivation {
      name = "evalysEnv";
      buildInputs = [ pkgs.python3 pkgs.python35Packages.matplotlib evalys  ];
      shellHook = ''
        python3 -i -c "import evalys;import matplotlib;matplotlib.use('Qt5Agg');from matplotlib import pyplot as plt"
      '';
    };
  };
in
  self
