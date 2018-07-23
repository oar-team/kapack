{ stdenv, openmpi, openmpi_rsg_plugins, python }:

stdenv.mkDerivation rec {
# name = "openmpi-3.1.1";
  name = "openmpi-rsg-u"; # BEWARE: Length must equal openmpi package's
  src = "${openmpi_rsg_plugins}"; # We have no source here...

  nativeBuildInputs = [ python ];
  buildInputs = [ openmpi openmpi_rsg_plugins ];
  installPhase = ''
    mkdir -p $out/lib/openmpi

    # Retrieve OpenMPI binaries, hacking their hardcoded install path.
    # This is done in python, for sanity's sake
    export OPENMPI=${openmpi}
    export OUT=$out

    python_cmd=$(cat <<-END
    import glob
    import os

    old_path = os.environ['OPENMPI']
    new_path = os.environ['OUT']

    files_to_copyhack = \
        glob.glob(old_path + "/bin/**", recursive=True) + \
        glob.glob(old_path + "/lib/**", recursive=True) + \
        glob.glob(old_path + "/etc/**", recursive=True) + \
        glob.glob(old_path + "/share/**", recursive=True)

    for filename in files_to_copyhack:
        # Only work on files
        if not os.path.isfile(filename):
            continue

        old_mode = os.stat(filename).st_mode

        new_filename = filename.replace(old_path, new_path)
        print('{old} -> {new}'.format(old=filename, new=new_filename))

        with open(filename, 'rb') as f:
            # Just read the content
            content = f.read()

            # Hack the path into the file content
            content = content.replace(old_path.encode('ascii'), new_path.encode('ascii'))

            # Create directory (recursively) if needed
            os.makedirs(os.path.dirname(new_filename), exist_ok=True)

            # Write hacked content to the output file (in the nix store)
            with open(os.open(new_filename, os.O_CREAT | os.O_WRONLY, old_mode), 'wb') as fw:
                fw.write(content)
            # TODO: handle links (ln) correctly
    END
    )
    python -c "$python_cmd"

    # Copy plugins
    cp ${openmpi_rsg_plugins}/lib/openmpi/* $out/lib/openmpi/
  '';
}
