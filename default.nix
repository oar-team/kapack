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

    # use Clang instead of GCC
    # NOTE: Clang seems to optimize things even with -O0 so don't use this for debug
    #stdenv = pkgs.clangStdenv;

    # Batsim tools an dependencies
    # FIXME: Maybe use upstream Simgrid instead
    simgrid = callPackage ./simgrid { };
    simgrid_dev = callPackage ./simgrid/dev.nix { };
    simgrid_dev_batsim = callPackage ./simgrid/dev_batsim.nix { };
    simgrid_batsim = callPackage ./simgrid/batsim.nix { inherit simgrid; };
    simgrid_remotesg = callPackage ./simgrid/remotesg.nix { inherit simgrid; };
    simgrid_temperature = callPackage ./simgrid/temperature.nix { inherit simgrid; };
    remote_simgrid = callPackage ./remote-simgrid { };
    remote_simgrid_dev = callPackage ./remote-simgrid/dev.nix {
      remote_simgrid = remote_simgrid; };
    openmpi_rsg_plugins = callPackage ./openmpi-rsg-plugins {};
    openmpi_rsg_plugins_dev = callPackage ./openmpi-rsg-plugins/dev.nix {};
    pajeng = callPackage ./pajeng { };
    batexpe = callPackage ./batexpe { };
    batsim = callPackage ./batsim { simgrid = simgrid_batsim; };
    batsim140 = callPackage ./batsim/batsim140.nix { batsim = batsim; };
    batsim_dev = callPackage ./batsim/dev.nix {
      simgrid = simgrid_dev_batsim;
      batsched = batsched_dev;
      pybatsim = pybatsim_dev;
    };
    batsim_dev_upstreamsg = callPackage ./batsim/dev.nix {
      simgrid = simgrid_dev;
      batsched = batsched_dev;
      pybatsim = pybatsim_dev;
    };
    batsim_temperature = callPackage ./batsim/dev.nix {
      batsim = batsim.override { simgrid = simgrid_temperature; };
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
    procset_dev = callPackage ./procset/dev.nix { };
    evalys = callPackage ./evalys { };
    execo = callPackage ./execo { };
    # TODO push this in nixpkgs (not even used here anymore)
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
    yamldiff = callPackage ./yamldiff { };
    gocov = callPackage ./gocov { };
    gocovmerge = callPackage ./gocovmerge { };
    gocov_xml = callPackage ./gocov-xml { };

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
