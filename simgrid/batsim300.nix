{ simgrid, fetchurl }:

simgrid.overrideAttrs (oldAttrs: rec {
  version = "for-batsim-3.0.0";
  rev = "97b4fd8e435a44171d471a245142e6fd0eb992b2";
  name = "simgrid-${version}";

  src = fetchurl {
    url = "https://framagit.org/simgrid/simgrid/-/archive/${rev}/simgrid-${rev}.tar.gz";
    sha256 = "13bpr3lh1mkq2n1p8zjyv964rq5j00429iysad2axq2246v4kv6a";
  };
  patches = [];

  doCheck = false;
})
