{ stdenv, batexpe, procps, iproute
}:

# Intended to be used with nix-shell. For example:
# nix-shell /path/to/datamovepkgs -A robin
stdenv.mkDerivation rec {
  name = "robin";
  propagatedBuildInputs = [batexpe procps iproute];
  meta = with stdenv.lib; {
  };
}
