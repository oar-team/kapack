{ stdenv, fetchFromGitHub, pkgs, pythonPackages, zeromq ,powercap }:

pythonPackages.buildPythonPackage rec {

  src = fetchFromGitHub {
    owner = "oar-team";
    repo = "colmet";
    rev = "f16d9ebd830c706291dd67b4bb5a6b368dd73bb5";
    sha256 = "0qzjn0v061n3w2pfji4d1yga2x8fs1ikxr872b2ng3q6829411ns";
  };

  propagatedBuildInputs = with pythonPackages; [
    requests
    pytest
    tables
    pyinotify
    pyzmq
  ];

  buildInputs = [ powercap ];
  name = "colmet3dev";

  # Colmet depends on some libraries located inside the repository
  # I handle them manually
  # 1) The patch, patches the makefiles that have a path to /usr/lib
  # 2) The preBuild changes the backends code to link to the path of this package
  patches = [ ./patch_makefile_backends ];

  preBuild = ''
    sed -i "s#/usr/lib/#$out/lib/#g" colmet/node/backends/perfhwstats.py
    sed -i "s#/usr/lib/#$out/lib/#g" colmet/node/backends/RAPLstats.py
  '';

  postBuildPhase = ''
    cd colmet/node/backends/lib_rapl; make
    cd colmet/node/backends/lib_perf_hw; make
  '';

  postInstall = ''
    mv colmet/node/backends/lib_rapl/lib_rapl.so $out/lib
    mv colmet/node/backends/lib_perf_hw/lib_perf_hw.so $out/lib
  '';

  # Tests do not pass
  doCheck = false;

  # Use this patch to enable cwd options for Process and make the engin
  # parameters override works
  # patches = [ ];

  meta = with stdenv.lib; {
    description = "Python library that allows you to finely manage unix processes on thousands of remote hosts";
    broken = false;
    homepage    = https://github.com/oar-team/colmet;
    platforms   = platforms.unix;
    license     = licenses.gpl2;
    longDescription = ''
    Colmet is a monitoring tool to collect metrics about jobs running in a
    distributed environnement, especially for gathering metrics on clusters
    and grids. It provides currently several backends : - taskstats: fetch
    task metrics from the linux kernel
    - stdout: display the metrics on the terminal
    - zeromq: transport the metrics across the network
    - hdf5: store the metrics on the filesystem
    '';
  };
}
