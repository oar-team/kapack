{ simgrid_dev, fetchgit }:

simgrid_dev.overrideAttrs (oldAttrs: rec {
  version = "dev-batsim";
  name = "simgrid-${version}";

  src = fetchgit {
    url = "https://github.com/simgrid/simgrid.git";
    rev = "163f8696544cfc2c11a545b9ed06011903780031";
    sha256 = "1liywah4sd2rac0j66jwzljn1wmc019qlkvry9gn8j7afpkgdxsg";
  };

  doCheck = false;
})
