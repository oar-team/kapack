{ stdenv, cmake, ninja, fetchFromGitHub }:
stdenv.mkDerivation rec {
  name = "gtest-${version}";
  version = "1.10.0";

  src = fetchFromGitHub {
    owner = "google";
    repo = "googletest";
    rev = "release-${version}";
    sha256 = "1zbmab9295scgg4z2vclgfgjchfjailjnvzc6f5x9jvlsdi3dpwz";
  };

  nativeBuildInputs = [ cmake ninja ];

  meta = with stdenv.lib; {
    description = "Google's framework for writing C++ tests";
    longDescription = description;
    broken = false;
    homepage = https://github.com/google/googletest;
    license = licenses.bsd3;
    platforms = platforms.all;
    maintainers = with maintainers; [ zoomulator ivan-tkatchev ];
  };
}
