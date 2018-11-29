{ batexpe }:
batexpe.overrideAttrs (attrs: rec {
    name = "batexpe-${version}";
    version = "2.0-dev";
    src = fetchTarball "https://gitlab.inria.fr/batsim/batexpe/repository/master/archive.tar.gz";
})
