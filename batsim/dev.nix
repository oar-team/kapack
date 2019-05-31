{ stdenv, batsim, simgrid }:

(batsim.override { simgrid = simgrid; }).overrideAttrs (attrs: rec {
  version = "3.2.0-dev";
  src = fetchTarball "https://gitlab.inria.fr/batsim/batsim/repository/master/archive.tar.gz";

  # Generate and keep DWARF information.
  mesonBuildType = "debug";
  hardeningDisable = [ "all" ];
  dontStrip = true;

  # Integration tests disabled for now.
  # Unit tests are not ported to meson yet as I write these lines.
  doCheck = false;

  # Fix --version display
  preConfigure = ''
    sed -iE "s/version: '.*',/version: '${version}',/" meson.build
  '';

  meta = attrs.meta;
})
