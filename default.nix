{
  hostPkgs ? import <nixpkgs> {},
  pkgs ? (let
      pinnedVersion = hostPkgs.lib.importJSON ./nixpkgs-19.03.json;
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
  # use Clang instead of GCC
  useClang ? false
}:
let
  # Add libraries to the scope of callPackage
  callPackage = path : attrset : check (pkgs.lib.callPackageWith (pkgs // pkgs.xlibs // self) path attrset);
  #ocamlCallPackage = pkgs.ocamlPackages.callPackageWith (pkgs // pkgs.xlibs // self);

  check = drv:
    let
    makeC = c : s : if c then true else throw ''meta attribute missing or incorrect: missing the "${s}" attribute.'';
    test = meta:
      (makeC (meta ? longDescription ) "longDescription")  &&
      (makeC (meta ? description     ) "description")  &&
      (makeC (meta ? homepage        ) "homepage")  &&
      (makeC (meta ? platforms       ) "platforms")  &&
      (makeC (meta ? license         ) "license") &&
      (makeC (meta ? broken          ) "broken");
    in if (test drv.meta) then drv else {};

  self = rec {
    # Freeze python version to 3.6
    pythonPackages = pkgs.python36Packages;
    python = pkgs.python36;

    # Batsim tools an dependencies
    # "simgrid" is defined in pkgs
    simgrid317 = callPackage ./simgrid/simgrid317.nix { };
    simgrid322_2 = callPackage ./simgrid/simgrid322_2.nix { };
    simgrid_dev = callPackage ./simgrid/dev.nix { };
    simgrid_dev_working = callPackage ./simgrid/dev_working.nix { };
    simgrid_batsim140or200 = callPackage ./simgrid/batsim140or200.nix { simgrid = simgrid317; };
    simgrid_batsim3 = callPackage ./simgrid/batsim300.nix { simgrid = simgrid317; };
    simgrid_remotesg = callPackage ./simgrid/remotesg.nix { simgrid = simgrid317; };
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

    batsim1 = callPackage ./batsim/batsim140.nix { batsim = batsim2; };
    batsim2 = callPackage ./batsim/batsim200.nix { simgrid = simgrid_batsim140or200; };
    batsim300 = callPackage ./batsim/batsim300.nix { simgrid = simgrid_batsim3; };
    batsim310 = callPackage ./batsim/batsim310.nix { simgrid = simgrid322_2; };
    batsim = batsim310;
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
    batsched12 = callPackage ./batsched/batsched121.nix { };
    batsched13 = callPackage ./batsched/batsched130.nix { };
    batsched = batsched13;
    batsched_dev = callPackage ./batsched/dev.nix { batsched = batsched13; };
    pybatsim2 = callPackage ./pybatsim/pybatsim2.nix { };
    pybatsim3 = callPackage ./pybatsim/pybatsim3.nix { };
    pybatsim = pybatsim3;
    pybatsim_dev = callPackage ./pybatsim/dev.nix { };
    batbroker = callPackage ./batbroker/default.nix { };
    intervalset = callPackage ./intervalset { };
    redox = callPackage ./redox { };
    rapidjson = callPackage ./rapidjson { };
    procset = callPackage ./procset { };
    procset_dev = callPackage ./procset/dev.nix { };
    evalys = callPackage ./evalys { };
    evalys4 = callPackage ./evalys/evalys4.nix { };
    execo = callPackage ./execo { };
    docopt_cpp = callPackage ./docopt-cpp { };
    pugixml = callPackage ./pugixml { shared = true; };
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

    evalysEnv = (python.withPackages (ps: [ ps.ipython evalys4 ])).env;

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
          evalys4
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
    oar_lib = callPackage ./oar/oarlib.nix { };
    oardocker = callPackage ./oardocker { };

    gemmpi = callPackage ./gemmpi {};
    gemmpi_with_mpi = callPackage ./gemmpi/env.nix { inherit pkgs openmpi; };

    inherit pkgs;
    inherit pkgs-unstable;
  }
  // pkgs.stdenv.lib.optionalAttrs useClang { stdenv = pkgs.clangStdenv; };
in
  self
