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

  rev = "b88233071eaaef45c854e84a8c7b460ab5793b7d";
  src = fetchTarball "https://github.com/simgrid/simgrid/archive/${rev}.tar.gz";
  doCheck = false;
})
