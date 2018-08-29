{ stdenv, fetchurl, pybatsim }:
pybatsim.overrideAttrs (attrs: rec {
  name = "pybatsim-2.0";
  src = fetchurl {
    url = "https://pypi.python.org/packages/56/32/37c5c5fcd2c770b986e4ae05395004531176cb291e54a6f4ce0434b89e3d/pybatsim-2.0.tar.gz";
    sha256 = "1185e6c38676903fe230212f550f6a7ff3ab8670f074279a894071225924c951";
  };
})
