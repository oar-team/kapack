{ dockerTools, stdenv
, coreutils
, nix
, cacert
, bashInteractive
, curl
, findutils
, gnutar
, gzip
, commonsCompress }:
version: dockerTools.buildImage rec {
  name = "oarteam/nix";
  tag = version;
  #fromImage = dockerTools.pullImage {
  #  imageName = "debian";
  #  sha256 = "0jsn5gg87bsar7y2yv7wwf8b7vr1rj1v6bbjnivgvimvg72llgph";
  #};

  contents = [
    coreutils
    findutils
    cacert
    bashInteractive
    curl
    nix
    gnutar
    commonsCompress];
  runAsRoot = ''
    #!${stdenv.shell}
    ${dockerTools.shadowSetup}

    mkdir /tmp

    groupadd --gid 30000 --system nixbld && \
    for i in $(seq 1 30); do \
      useradd --system --home-dir /var/empty --comment "Nix build user $i" \
      --uid $((30000 + i)) -G nixbld nixbld$i
    done
    ${nix}/bin/nix-store --init
    ${nix}/bin/nix-env -i ${builtins.toString contents}
    ${nix}/bin/nix-channel --add https://nixos.org/channels/nixos-unstable nixpkgs
    ${nix}/bin/nix-channel --update

    '';
  config = {
    Env = [
      "ENV=/etc/profile"
      "PATH=/nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/default/sbin:/bin:/sbin:/usr/bin:/usr/sbin"
      "GIT_SSL_CAINFO=${cacert}/etc/ssl/certs/ca-bundle.crt"
      "NIX_SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt"
      "NIX_PATH=/nix/var/nix/profiles/per-user/root/channels" ];
    #Entrypoint = [ "${bashInteractive}/bin/bash" ];
    WorkingDir = "/mynixpkgs";
  };
}
