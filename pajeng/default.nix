{ stdenv, fetchFromGitHub, cmake, boost, flex, bison }:

stdenv.mkDerivation rec {
  version = "1.3.4";
  name = "pajeng-${version}";
  src = fetchFromGitHub {
    owner = "schnorr";
    repo = "pajeng";
    rev = "master";
    sha256 = "1l7x7whg1n82c3m4b1wfb7krar4vwh0xx97cmmmc1rq6l23qz9jw";
  };

  nativeBuildInputs = [ cmake boost flex bison ];

  meta = with stdenv.lib; {
    description = "Paje Next Generation - Data Analysis of Paje Files";
    longDescription =
      '' PajeNG (Paje Next Generation) is a re-implementation (in C++) and
        direct heir of the well-known Paje visualization tool for the analysis
        of execution traces (in the Paje File Format) through trace
        visualization (space/time view). The tool is released under the GNU
        General Public License 3. PajeNG comprises the libpaje library, and a
        set of auxiliary tools to manage Paje trace files (such as pj_dump and
        pj_validate). The space-time visualization tool called pajeng is
        deprecated (removed from the sources) since modern tools do a better job
        (see pj_gantt, for instance, or take a more general approach using
        R+ggplot2 to visualize the output of pj_dump). This effort was started
        as part of the french INFRA-SONGS ANR project. Development has continued
        through a collaboration between INF/UFRGS and INRIA.  '';
    homepage = "http://paje.sourceforge.net/";
    maintainers = with maintainers; [ "mickours" ];
    platforms = platforms.x86_64;
    license = licenses.gpl3;
  };
}
