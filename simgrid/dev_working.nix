{ simgrid_dev, fetchgit }:

simgrid_dev.overrideAttrs (oldAttrs: rec {
  version = "dev-ok";
  name = "simgrid-${version}";

  #          *
  #         * *
  #        *   *         DO NOT UPDATE MANUALLY!
  #       *  *  *        This package is a working version of simgrid_dev.
  #      *   *   *       Update by calling update-working.bash
  #     *    *    *
  #    *           *
  #   *      *      *
  #  *               *
  # *******************

  rev = "5256bf5722d6ccd15cfae45d774b5c6e35a4dd3e";
  src = fetchTarball "https://github.com/simgrid/simgrid/archive/${rev}.tar.gz";
  doCheck = false;
})
