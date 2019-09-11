# edited from nixpkgs, with a quick&dirty pkg-config support
{ stdenv, fetchurl, m4
, cxx ? !stdenv.hostPlatform.useAndroidPrebuilt && !stdenv.hostPlatform.isWasm
, withStatic ? false }:

let inherit (stdenv.lib) optional; in

let self = stdenv.mkDerivation rec {
  pname = "gmp";
  version = "6.1.2";
  name = "${pname}-${version}";

  src = fetchurl {
    urls = [ "mirror://gnu/gmp/${name}.tar.bz2" "ftp://ftp.gmplib.org/pub/${name}/${name}.tar.bz2" ];
    sha256 = "1clg7pbpk6qwxj5b2mw0pghzawp2qlm3jf9gdd8i6fl6yh2bnxaj";
  };

  nativeBuildInputs = [ m4 ];

  configureFlags = [
    "--with-pic"
    "--enable-cxx"
    "--disable-static"
  ];

  doCheck = true;
  postInstall = ''
    mkdir -p $out/lib/pkgconfig
    cat <<EOF >>$out/lib/pkgconfig/gmp.pc
Name: gmp
Description: A free library for arbitrary precision arithmetic.
Version: ${version}
Libs: -L$out/lib -lgmp
Cflags: -I$out/include
EOF
   cat <<EOF >>$out/lib/pkgconfig/gmpxx.pc
Name: gmpxx
Description: A free library for arbitrary precision arithmetic.
Version: ${version}
Requires: gmp
Libs: -L$out/lib -lgmpxx
Cflags: -I$out/include
EOF
  '';

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    homepage = https://gmplib.org/;
    description = "GNU multiple precision arithmetic library";
    license = licenses.gpl3Plus;
    broken = false;

    longDescription =
      '' GMP is a free library for arbitrary precision arithmetic, operating
         on signed integers, rational numbers, and floating point numbers.
         There is no practical limit to the precision except the ones implied
         by the available memory in the machine GMP runs on.  GMP has a rich
         set of functions, and the functions have a regular interface.

         The main target applications for GMP are cryptography applications
         and research, Internet security applications, algebra systems,
         computational algebra research, etc.

         GMP is carefully designed to be as fast as possible, both for small
         operands and for huge operands.  The speed is achieved by using
         fullwords as the basic arithmetic type, by using fast algorithms,
         with highly optimised assembly code for the most common inner loops
         for a lot of CPUs, and by a general emphasis on speed.

         GMP is faster than any other bignum library.  The advantage for GMP
         increases with the operand sizes for many operations, since GMP uses
         asymptotically faster algorithms.
      '';

    platforms = platforms.all;
  };
};
  in self
