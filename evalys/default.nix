{ stdenv, fetchFromGitHub, python35Packages, interval_set}:

python35Packages.buildPythonPackage rec {
  name = "evalys-git";

  src = fetchFromGitHub {
    owner = "oar-team";
    repo = "evalys";
    rev = "dfcfcf7fc0b3388c6af366e4727db3dc104a47a5";
    sha256 = "143mq2j1ykz86k9zd43nk0jsj89i506pki6m3kgknrk7d32imshh";
  };

  propagatedBuildInputs = with python35Packages; [
    interval_set
    seaborn
    pandas
    pyqt5
    matplotlib ];

  checkInputs = with python35Packages; [ pytest ];

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
