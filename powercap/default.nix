{ stdenv, fetchurl, cmake }:

stdenv.mkDerivation rec {
  name = "powercap-${version}";
  version = "v0.1.1";

  src = fetchurl {
    url = "https://github.com/powercap/powercap/archive/v0.1.1.tar.gz";
    sha256 = "0i21mrn1ajqwwmkqcxr2myl3lgnyw45wrvx50i7i7hhj8ijbw0dy";
  };

  nativeBuildInputs = [ cmake ];

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "C bindings to the Linux Power Capping Framework in sysfs";
    longDescription = "This project provides the powercap library -- a generic C interface to the Linux power capping framework (sysfs interface). It includes an implementation for working with Intel Running Average Power Limit (RAPL).";
    homepage    = "https://github.com/powercap/powercap";
    platforms   = platforms.unix;
    license = licenses.bsd3;
    broken = false;
  };
}
