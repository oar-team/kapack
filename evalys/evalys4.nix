{evalys, pythonPackages}:
evalys.overrideAttrs (oldAttrs: rec {
  inherit (oldAttrs) pname;
  version = "4.0.0";
  name = "${pname}-${version}";

  src = pythonPackages.fetchPypi {
    inherit pname version;
    sha256 = "1qw4w6nlldh8ify834nynjn1sw8pjkxr4ip9brj6sz4xjhy54kl2";
  };
})
