#{pkgs ? import (fetchTarball https://github.com/nixos/nixpkgs-channels/archive/nixos-unstable.tar.gz) {} }:
{pkgs ? import ../nixpkgs {} }:
let
  callPackage = pkgs.lib.callPackageWith (pkgs // pkgs.xlibs // self);
  #ocamlCallPackage = pkgs.ocamlPackages.callPackageWith (pkgs // pkgs.xlibs // self);
  self = rec {
    simgrid_batsim = callPackage ./simgrid/batsim.nix { };
    boost_gcc6 = pkgs.boost.overrideDerivation (oldAttrs: rec {
      nativeBuildInputs = pkgs.gcc6;
    });
    batsim = callPackage ./batsim { };
    batsimTests = callPackage ./batsim/tests.nix { };
    redox = callPackage ./redox { };
    rapidjson = callPackage ./rapidjson { };
    interval_set = callPackage ./interval-set { };
    evalys = callPackage ./evalys { inherit interval_set; };
    execo = callPackage ./execo { };
    obandit = pkgs.ocamlPackages.callPackage ./obandit { };
    zymake = pkgs.ocamlPackages.callPackage ./zymake { };
    su_exec = callPackage ./suexec.nix { };
    ocs = pkgs.ocamlPackages.callPackage ./ocs { inherit obandit; };
    evalysEnv = pkgs.stdenv.mkDerivation {
      name = "evalysEnv";
      buildInputs = [ pkgs.python3 pkgs.python35Packages.matplotlib pkgs.python35Packages.ipython evalys  ];
      shellHook = ''
        ipython3 -i -c "import evalys;import matplotlib;matplotlib.use('Qt5Agg');from matplotlib import pyplot as plt"
      '';
    };
    execoEnv = pkgs.stdenv.mkDerivation {
      name = "execoEnv";
      buildInputs = [ pkgs.python3 pkgs.python35Packages.ipython execo  ];
      shellHook = ''
        ipython3 -i -c "import execo"
      '';
    };
    batsim_git = batsim.overrideDerivation (attrs: rec {
      version = "dev";
      src = pkgs.fetchgit {
        url = "file:///home/mercierm/Projects/batsim";
        rev = "cac343d5a60111b2f21778b507c9e79aebebca3f";
        fetchSubmodules = false;
      };
      doInstallCheck = false;
      # Add debug tools
      # propagatedNativeBuildInputs = attrs.propagatedNativeBuildInputs ++ [ pkgs.cmake pkgs.bash ];
    });
    debianImage = pkgs.dockerTools.pullImage {
      image = "debian:jessie";
      sha256 = "1n1v72kcyxm7chnb0qafdzkfk7vybicix23vd6f380bhcyvx6mm3";
    };
    busyBoxImage = pkgs.dockerTools.pullImage {
      image = "busybox:latest";
      sha256 = "1ndqwxzmm88wq2hgvyvikrakh4a6h65ar5nf22d16fzm89jxf51f";
    };
    batsimImage = callPackage ./batsim/batsim-docker.nix {};
    batsimDocker_git = batsimImage batsim_git null;
    batsimDocker_debug = batsimImage batsim_git busyBoxImage;
    batsimDocker_gitOnDebian = batsimImage batsim_git debianImage;
  };
in
  self
