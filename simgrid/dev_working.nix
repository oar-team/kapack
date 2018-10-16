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

  rev = "f9b70a2e6b1e4076a895a8492e614c77d5eb4bf7";
  src = fetchTarball "https://github.com/simgrid/simgrid/archive/${rev}.tar.gz";
  doCheck = false;
})
