{ stdenv, batsim, dockerTools}:

batsim: baseImage: dockerTools.buildImage {
  name = "oarteam/batsim";
  tag = batsim.version;
  fromImage = baseImage;

  config = {
    Entrypoint = [ "${batsim}/bin/batsim" ];
    ExposedPorts = {
      "28000/tcp" = {};
    };
    WorkingDir = "/data";
    Volumes = {
      "/data" = {};
    };
  };
}
