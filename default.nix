{
  pkgs ? import <nixpkgs> {},
  mylib ? import ./mylib {}
}:
let
  # Add libraries to the scope of callPackage
  callPackage = pkgs.lib.callPackageWith (pkgs // pkgs.xlibs // mylib // self);
  #ocamlCallPackage = pkgs.ocamlPackages.callPackageWith (pkgs // pkgs.xlibs // self);
  self = rec {
    simgrid_batsim = callPackage ./simgrid/batsim.nix { };
    batsim = callPackage ./batsim { };
    pybatsim = callPackage ./pybatsim { };
    redox = callPackage ./redox { };
    rapidjson = callPackage ./rapidjson { };
    procset = callPackage ./procset { };
    evalys = callPackage ./evalys { };
    nnpy = callPackage ./nnpy { };
    nanomsg = callPackage ./nanomsg { };
    obandit = pkgs.ocamlPackages.callPackage ./obandit { };
    ocaml-zmq = pkgs.ocamlPackages.callPackage ./ocaml-zmq { };
    bigstring = pkgs.ocamlPackages.callPackage ./bigstring { };
    oocvx = pkgs.ocamlPackages.callPackage ./oocvx { };
    zymake = pkgs.ocamlPackages.callPackage ./zymake { };
    stdint = pkgs.ocamlPackages.callPackage ./stdint { };
    onanomsg = pkgs.ocamlPackages.callPackage ./onanomsg { };
    ppx_deriving_protobuf = pkgs.ocamlPackages.callPackage ./ppx_deriving_protobuf { };
    ocs = pkgs.ocamlPackages.callPackage ./ocs { zmq=ocaml-zmq; };

    help = pkgs.stdenv.mkDerivation {
      name = "help";
      buildInputs = [ ocs ];
    };

    evalysEnv = pkgs.stdenv.mkDerivation rec {
      name = "evalysEnv";
      inherit (evalys) version;
      buildInputs = [
          pkgs.python3
          pkgs.python36Packages.matplotlib
          pkgs.python36Packages.ipython
          evalys  ];
    };

    #evalysEnvInteractive = pkgs.stdenv.mkDerivation rec {

    #  buildInputs = pkgs.python36.withPackages (ps: with ps; [evalys matplotlib]);
    #  inherit (evalys) version;

    #  shellHook = ''
    #      echo Evalys version: ${version}
    #      ipython3 -i -c "import evalys;import matplotlib;matplotlib.use('Qt5Agg');from matplotlib import pyplot as plt" && exit
    #  '';
    #};

    evalys_git = evalys.overrideDerivation (attrs: rec {
      version = "dev";
      src = builtins.fetchTarball "https://gitlab.inria.fr/batsim/evalys/repository/master/archive.tar.gz";
      doInstallCheck = false;
    });

    #evalysImage = callPackage ./evalys/docker.nix {};
    #evalysDocker = evalysImage evalysEnv null;

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

    batsimEnv = pkgs.stdenv.mkDerivation {
      name = "batsimEnv";
      buildInputs = [ batsim  ];
      shellHook = ''
        echo "Welcome to the batcave!!!"
        batsim --version
      '';
    };


  };
in
  self
