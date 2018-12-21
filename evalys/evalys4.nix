{evalys, pythonPackages}:
evalys.overrideAttrs (oldAttrs: rec {
  inherit (oldAttrs) pname;
  version = "4.0.2";
  name = "${pname}-${version}";

  src = pythonPackages.fetchPypi {
    inherit pname version;
    sha256 = "0709p54sbcy2783vmmim7rs7c12ycc4nzfpc2i3fkbwanm72bsd5";
  };
})
