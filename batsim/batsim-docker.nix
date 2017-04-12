{ stdenv, batsim_git, dockerTools}:

batsim: baseImage: dockerTools.buildImage {
  name = "batsim";
  tag = batsim.version;
  fromImage = baseImage;

  config = {
    Entrypoint = [ "${batsim_git}/bin/batsim" ];
    ExposedPorts = {
      "28000/tcp" = {};
    };
    WorkingDir = "/data";
    Volumes = {
      "/data" = {};
    };
  };
}
