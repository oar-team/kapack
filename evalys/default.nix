{ stdenv, fetchFromGitHub, python36Packages, procset}:

python36Packages.buildPythonPackage rec {
  name = "evalys-git";

  src = fetchFromGitHub {
    owner = "oar-team";
    repo = "evalys";
    rev = "9e590c6df6fdd2a9f2fa0255ac3d0bd6a4bb147c";
    sha256 = "00ald8r4ijbizw94jaxilhjcfblsnwy3f4ql63p528hh9hh5hvr1";
  };

  propagatedBuildInputs = with python36Packages; [
    procset
    seaborn
    pandas
    pyqt5
    matplotlib ];

  checkInputs = with python36Packages; [ pytest ];

  checkPhase = ''
    py.test tests
  '';
  doCheck=false;

  meta = with stdenv.lib; {
    description = "Infrastructure Performance Evaluation Toolkit Edit";
    homepage    = https://github.com/oar-team/evalys;
    platforms   = platforms.unix;

    longDescription = ''
      Evalys is a data analytics library made to load, compute,
      and plot data from job scheduling and resource management traces.
      It allows scientists and engineers to extract useful data and
      visualize it interactively or in an exported file.
    '';
  };
}
