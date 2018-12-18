{evalys, pythonPackages}:
evalys.overrideAttrs (oldAttrs: rec {
  inherit (oldAttrs) pname;
  version = "4.0.1";
  name = "${pname}-${version}";

  src = pythonPackages.fetchPypi {
    inherit pname version;
    sha256 = "0g4d0l2n0ms3msm5qfwi1z13wpmk0w2r5i3g5gqqbk79d2ab4n5l";
  };
})
