{ stdenv, fetchurl, pythonPackages }:
pythonPackages.buildPythonPackage rec {
  name = "gcovr-4.1";

  src = fetchurl {
    url = "mirror://pypi/g/gcovr/${name}.tar.gz";
    sha256 = "08hy6vqvq7q7xk0jb9pd5dvjnyxd9x9k0hzcfyqhv9yry8vw756a";
  };

  propagatedBuildInputs = with pythonPackages; [
    jinja2
  ];

  meta = {
    description = "A Python script for summarizing gcov data";
    longDescription = ''
      Gcovr provides a utility for managing the use of the GNU gcov utility
      and generating summarized code coverage results. This command is
      inspired by the Python coverage.py package, which provides a similar
      utility for Python.
    '';
    homepage = "https://www.gcovr.com/en/stable/";
    platforms = stdenv.lib.platforms.unix;
    license = "BSD";
    broken = false;
  };
}
