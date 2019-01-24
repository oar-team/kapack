{evalys, pythonPackages}:
evalys.overrideAttrs (oldAttrs: rec {
  inherit (oldAttrs) pname;
  version = "4.0.4";
  name = "${pname}-${version}";

  src = pythonPackages.fetchPypi {
    inherit pname version;
    sha256 = "1j9gp1zdfaip0kfyf64n1aa9ayllfb85xlbn0srmr4a2gb3r4jq7";
  };
})
