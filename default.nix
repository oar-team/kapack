{
  hostPkgs ? import <nixpkgs> {},
  pkgs ? (let
      pinnedVersion = hostPkgs.lib.importJSON ./nixpkgs-18.03.json;
      pinnedPkgs = hostPkgs.fetchFromGitHub {
        owner = "NixOS";
        repo = "nixpkgs-channels";
        inherit (pinnedVersion) rev sha256;
      };
    in import pinnedPkgs {}),
  pkgs-unstable ? (let
      pinnedVersion = hostPkgs.lib.importJSON ./nixpkgs-unstable.json;
      pinnedPkgs = hostPkgs.fetchFromGitHub {
        owner = "NixOS";
        repo = "nixpkgs-channels";
        inherit (pinnedVersion) rev sha256;
      };
    in import pinnedPkgs {}),
  mylib ? import ./mylib { inherit pkgs; },
  # use Clang instead of GCC
  useClang ? false
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
    simgrid_dev = callPackage ./simgrid/dev.nix { };
    simgrid_dev_working = callPackage ./simgrid/dev_working.nix { };
    simgrid_batsim140or200 = callPackage ./simgrid/batsim140or200.nix { inherit simgrid; };
    simgrid_remotesg = callPackage ./simgrid/remotesg.nix { inherit simgrid; };
    simgrid_temperature = callPackage ./simgrid/temperature.nix { };
    remote_simgrid = callPackage ./remote-simgrid {
      simgrid = simgrid_remotesg; };
    remote_simgrid_dev = callPackage ./remote-simgrid/dev.nix {
      simgrid = simgrid_dev_working; };
    openmpi = callPackage ./openmpi { };
    openmpi_dev = callPackage ./openmpi/dev_pinned.nix { };
    openmpi_rsg = callPackage ./openmpi-rsg { };
    openmpi_rsg_dev = callPackage ./openmpi-rsg {
      openmpi = openmpi_dev;
      openmpi_rsg_plugins = openmpi_rsg_plugins_dev;
    };
    openmpi_rsg_plugins = callPackage ./openmpi-rsg-plugins {
      simgrid = simgrid_remotesg;
      remote_simgrid = remote_simgrid;
    };
    openmpi_rsg_plugins_dev = callPackage ./openmpi-rsg-plugins/dev_pinned.nix {
      simgrid = simgrid_dev_working;
      remote_simgrid = remote_simgrid_dev;
      openmpi = openmpi_dev;
    };
    pajeng = callPackage ./pajeng { };
    batexpe = callPackage ./batexpe { };
    batexpe_dev = callPackage ./batexpe/dev.nix { };
    papi = pkgs-unstable.papi;
    npb = callPackage ./npb {
      openmpi = pkgs.openmpi;
    };
    # WARNING: NOT WORKING use extrae instead
    mini = callPackage ./mini {
    };
    npb_with_mini = callPackage ./npb {
      openmpi = pkgs.openmpi;
      enable_time_independant_trace = true;
      max_size_in_power_of_two = "7"; # 128 procs
    };
    extrae = callPackage ./extrae {
      openmpi = pkgs.openmpi;
    };

    batsim140 = callPackage ./batsim/batsim140.nix { batsim = batsim200; };
    batsim200 = callPackage ./batsim/batsim200.nix { simgrid = simgrid_batsim140or200; };
    batsim = batsim200;
    batsim_dev = callPackage ./batsim/dev.nix {
      simgrid = simgrid_dev_working;
      batsched = batsched_dev;
      batexpe = batexpe_dev;
    };
    batsim_upstreamsg = callPackage ./batsim/dev.nix {
      simgrid = simgrid_dev;
      batsched = batsched_dev;
    };
    batsim_temperature = callPackage ./batsim/dev.nix {
      simgrid = simgrid_temperature;
      batsched = batsched_dev;
    };
    batsched = callPackage ./batsched { };
    batsched_dev = callPackage ./batsched/dev.nix { };
    pybatsim = callPackage ./pybatsim/default.nix { };
    pybatsim20 = callPackage ./pybatsim/pybatsim20.nix { };
    pybatsim_dev = callPackage ./pybatsim/dev.nix { };
    batbroker = callPackage ./batbroker/default.nix { };
    intervalset = callPackage ./intervalset { };
    redox = callPackage ./redox { };
    rapidjson = callPackage ./rapidjson { };
    procset = callPackage ./procset { };
    procset_dev = callPackage ./procset/dev.nix { };
    evalys = callPackage ./evalys { };
    execo = callPackage ./execo { };
    # TODO push this in nixpkgs (not even used here anymore)
    coloredlogs = callPackage ./coloredlogs { inherit humanfriendly; };
    humanfriendly = callPackage ./humanfriendly { };
    gcovr = callPackage ./gcovr { };

    # l2sched tools and dependencies
    #nnpy = callPackage ./nnpy { };
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
    colmet = callPackage ./colmet {};
    # Misc.
    cgvg = callPackage ./cgvg { };
    cgvg_mpoquet = callPackage ./cgvg/mpoquet.nix { };
    yamldiff = callPackage ./yamldiff { };
    gocov = callPackage ./gocov { };
    gocovmerge = callPackage ./gocovmerge { };
    gocov_xml = callPackage ./gocov-xml { };
    loguru = callPackage ./loguru { };

    evalysEnv = (python.withPackages (ps: [ ps.ipython evalys ])).env;

    evalysNotebookEnv = pkgs.stdenv.mkDerivation rec {
      name = "evalysNotebook";
      LC_ALL = "C";
      XDG_RUNTIME_DIR="/tmp/evalysNotebook-tmp";

      shellHook = ''
        echo -e "\e[32m=============================================\e[0m"
        echo -e "\e[32m=== Welcome to evalysNotebook environment ===\e[0m"
        echo -e "\e[32m=============================================\e[0m"

        export XDG_RUNTIME_DIR="/tmp/evalysNotebook-tmp"
        jupyter-notebook --ip $(hostname)

        echo -e "\e[32m=============================================\e[0m"
        echo -e "\e[32m===            Good Bye!                  ===\e[0m"
        echo -e "\e[32m=============================================\e[0m"
        exit 0
      '';
      env = pkgs.buildEnv { name = name; paths = buildInputs; };
      buildInputs = [
        pkgs.wget
        (python.withPackages (ps: with ps; [
          jupyter
          evalys
          pip
        ]))
      ];
    };

    batsimImage = callPackage ./batsim/batsim-docker.nix {};
    batsimDocker = batsimImage batsim null;
    platform_calibration = callPackage ./platform-calibration {};

    # Oar lib and some dependencies
    sqlalchemy_utils = callPackage ./sqlalchemy-utils { };
    pytest_flask = callPackage ./pytest-flask { };
    oar = callPackage ./oar { };
    oar_dev = callPackage ./oar/dev.nix { };
    oardocker = callPackage ./oardocker { };
  
    inherit pkgs;
    inherit pkgs-unstable;
  }
  // pkgs.stdenv.lib.optionalAttrs useClang { stdenv = pkgs.clangStdenv; };
in
  self
