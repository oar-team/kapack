{ stdenv, pypi_url, fetchurl, pythonPackages, procset}:
pythonPackages.buildPythonPackage rec {
  pname = "evalys";
  version = "2.6.1";
  name = "${pname}-${version}";

  src = fetchurl {
    url = pypi_url pname name;
    sha256 = "25c4806121764afdd657cc43ff25ac233fd4f9ce4e398f1fbe29b87fed36dbe1";
  };

  propagatedBuildInputs = with pythonPackages; [
    procset
    seaborn
    pandas
    pyqt5
    ipywidgets
    matplotlib
  ];

  # FIXME: tests are not passing and need to be refactored...
  doCheck = false;

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
