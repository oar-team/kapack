{
  pkgs ? import (
    fetchTarball "https://github.com/NixOS/nixpkgs/archive/17.09.tar.gz") {},
    #pkgs-unstable ? import (
    #pkfetchTarball "https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz") {},
  mylib ? import ./mylib {}
}:
let
  # Add libraries to the scope of callPackage
  callPackage = pkgs.lib.callPackageWith (pkgs // pkgs.xlibs // mylib // self);
  #ocamlCallPackage = pkgs.ocamlPackages.callPackageWith (pkgs // pkgs.xlibs // self);

  self = rec {
    # Freeze python version to 3.6
    pythonPackages = pkgs.python36Packages;
    python = pkgs.python36;

    # Batsim tools an dependencies
    simgrid = callPackage ./simgrid { };
    simgrid_batsim = callPackage ./simgrid/batsim.nix { inherit simgrid; };
    simgrid_remotesg = callPackage ./simgrid/remotesg.nix { inherit simgrid; };
    remote_simgrid = callPackage ./remote-simgrid { };
    batexpe = callPackage ./batexpe { };
    batsim = callPackage ./batsim { };
    batsim_dev = callPackage ./batsim/dev.nix {
      batsched = batsched_dev;
      pybatsim = pybatsim_dev;
    };
    batsched = callPackage ./batsched { };
    batsched_dev = callPackage ./batsched/dev.nix { };
    pybatsim = callPackage ./pybatsim { };
    pybatsim_dev = callPackage ./pybatsim/dev.nix { };
    redox = callPackage ./redox { };
    rapidjson = callPackage ./rapidjson { };
    procset = callPackage ./procset { };
    evalys = callPackage ./evalys { };
    execo = callPackage ./execo { };
    # TODO push this in nixpkgs
    coloredlogs = callPackage ./coloredlogs { inherit humanfriendly; };
    humanfriendly = callPackage ./humanfriendly { };

    # l2sched tools and dependencies
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
    cuneiformlang = callPackage ./cuneiformlang { };

    # Misc.
    cgvg = callPackage ./cgvg { };
    cgvg_mpoquet = callPackage ./cgvg/mpoquet.nix { };

    evalysEnv = (python.withPackages (ps: [ ps.ipython evalys ])).env;

    evalysNotebookEnv = (python.withPackages (ps: with ps; [
        jupyter
        evalys
        pip
      ])).env;

    batsimImage = callPackage ./batsim/batsim-docker.nix {};
    batsimDocker = batsimImage batsim null;
    inherit pkgs;
  };
in
  self
