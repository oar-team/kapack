{evalys, pythonPackages}:
evalys.overrideAttrs (oldAttrs: rec {
  inherit (oldAttrs) pname;
  version = "4.0.3";
  name = "${pname}-${version}";

  src = pythonPackages.fetchPypi {
    inherit pname version;
    sha256 = "0yywih3pv4w4ynl3b3dz9wz0qkhiqyrph5srl330wla2ycyppwb1";
  };
})
