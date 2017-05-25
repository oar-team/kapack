{ stdenv, fetchFromGitHub, python35Packages, nanomsg}:
python35Packages.buildPythonPackage rec {
  name = "nnpy";

  src = fetchFromGitHub {
    owner = "nanomsg";
    repo = "nnpy";
    rev = "c1d0e8c3d828ded4f92816594becf5c19e179944";
    sha256 = "19r65irxh6givs8x3k9qci6m9x2nz20sxjpalrinxvwawy73196m";
  };

  propagatedBuildInputs = [  python35Packages.cffi ];
  buildInputs = [ nanomsg  ];
  #nativeBuildinputs = [ pkgconfig ];

  patches = [ ./nnpy.patch ];

  preConfigure = ''
    substituteInPlace generate.py \
      --replace '@NIXNANOMSGHEADER@' '${nanomsg}/include/nanomsg'
    substituteInPlace generate.py \
      --replace '@NIXNANOMSGLIB@' '${nanomsg}/lib/libnanomsg.so'
  '';

  doCheck=false;

  meta = with stdenv.lib; {
    description = "cffi-based python bindings for nanomsg";
    homepage    = https://github.com/oar-team/interval_set;
    platforms   = platforms.unix;
  };
}
