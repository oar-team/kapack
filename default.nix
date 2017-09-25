{pkgs ? import <nixpkgs> {} }:
let
  callPackage = pkgs.lib.callPackageWith (pkgs // pkgs.xlibs // self);
  #ocamlCallPackage = pkgs.ocamlPackages.callPackageWith (pkgs // pkgs.xlibs // self);
  self = rec {
    simgrid_batsim = callPackage ./simgrid/batsim.nix { };
    batsim = callPackage ./batsim { };
    pybatsim = callPackage ./pybatsim { };
    redox = callPackage ./redox { };
    rapidjson = callPackage ./rapidjson { };
    procset = callPackage ./procset { };
    evalys = callPackage ./evalys { inherit procset; };
    nnpy = callPackage ./nnpy { };
    nanomsg = callPackage ./nanomsg { };
    obandit = pkgs.ocamlPackages.callPackage ./obandit { };
    ocaml-zmq = pkgs.ocamlPackages.callPackage ./ocaml-zmq { inherit stdint; };
    bigstring = pkgs.ocamlPackages.callPackage ./bigstring { };
    oocvx = pkgs.ocamlPackages.callPackage ./oocvx { };
    zymake = pkgs.ocamlPackages.callPackage ./zymake { };
    stdint = pkgs.ocamlPackages.callPackage ./stdint { };
    onanomsg = pkgs.ocamlPackages.callPackage ./onanomsg { inherit nanomsg bigstring; };
    ppx_deriving_protobuf = pkgs.ocamlPackages.callPackage ./ppx_deriving_protobuf { };
    ocs = pkgs.ocamlPackages.callPackage ./ocs {
      inherit obandit oocvx ppx_deriving_protobuf;
      zmq=ocaml-zmq;
    };

    help = pkgs.stdenv.mkDerivation {
      name = "help";
      buildInputs = [ ocs ];
    };

    evalysEnv = pkgs.stdenv.mkDerivation {
      name = "evalysEnv";
      buildInputs = [ pkgs.python3 pkgs.python36Packages.matplotlib evalys  ];
      shellHook = ''
          python3 -i -c "import evalys;import matplotlib;matplotlib.use('Qt5Agg');from matplotlib import pyplot as plt"
      '';
    };

    batsim_git = batsim.overrideDerivation (attrs: rec {
      version = "dev";
      src = builtins.fetchTarball "https://gitlab.inria.fr/batsim/batsim/repository/master/archive.tar.gz";
      doInstallCheck = false;
      propagatedNativeBuildInputs = [ ];
      # Add debug tools
      # propagatedNativeBuildInputs = attrs.propagatedNativeBuildInputs ++ [ pkgs.cmake pkgs.bash ];
    });

    batsimImage = callPackage ./batsim/batsim-docker.nix {};
    batsimDocker_git = batsimImage batsim_git null;
    batsimDocker = batsimImage batsim null;
  };
in
  self
