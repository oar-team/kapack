{pkgs ? import <nixpkgs> {} }:
with pkgs;

pkgs.python35Packages.buildPythonPackage rec {
  name = "nnpy";

  src = fetchFromGitHub {
    owner = "nanomsg";
    repo = "nnpy";
    rev = "c1d0e8c3d828ded4f92816594becf5c19e179944";
    sha256 = "19r65irxh6givs8x3k9qci6m9x2nz20sxjpalrinxvwawy73196m";
  };

  buildInputs = [ nanomsg python35Packages.cffi ];
  nativeBuildinputs = [ pkgconfig ];

  patchPhase = ''
    sed -i 's@/usr/include/nanomsg@${nanomsg}/include/nanomsg@' generate.py
    sed -i "s@, '/usr/local/include/nanomsg'@@" generate.py
  '';

  meta = with stdenv.lib; {
    description = "cffi-based python bindings for nanomsg";
    homepage    = https://github.com/nanomsg/nnpy;
    platforms   = platforms.unix;
  };
}
