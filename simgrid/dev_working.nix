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

  rev = "97b4fd8e435a44171d471a245142e6fd0eb992b2";
  src = fetchTarball "https://github.com/simgrid/simgrid/archive/${rev}.tar.gz";
  doCheck = false;
})
