{ simgrid, fetchFromGitHub }:

simgrid.overrideAttrs (oldAttrs: rec {
  name = "simgrid-temperature";

  src = fetchFromGitHub {
    owner = "simgrid";
    repo = "simgrid";
    rev = "6f5199d14e3f1b6505d3e264257bfe64bd991ca7";
    sha256 = "1al6pi1h0sgwhjshmkckb3spjxg1y1njlrnd3j0jbk4mp8g3m4j6";
  };

  patches = [ ./temperature.patch ];

  doCheck = false;
})
