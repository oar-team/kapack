{ stdenv, pythonPackages }:

pythonPackages.buildPythonPackage rec {
  pname = "oardocker";
  version = "1.5.0dev";
  
  src = fetchGit {
    url = "https://github.com/oar-team/oar-docker.git";
    rev = "33a146bb19d2eb0966a0979b87ab504f80144b5b";
    ref = "master";
  };
  
  propagatedBuildInputs = with pythonPackages; [
    click
    docker
    sh
    tabulate
    websocket_client
    arrow
  ];
  
  doCheck = false;
  
  meta = with stdenv.lib; {
    homepage = "https://github.com/oar-team/oar-docker";
    description = "Manage a small OAR developpement cluster with Docker.";
    license = licenses.lgpl3;
  };
}
