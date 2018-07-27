{ stdenv, openmpi, openmpi_rsg_plugins, python, rsync }:

stdenv.mkDerivation rec {
# name = "openmpi-3.1.1";
  name = "openmpi-rsg-u"; # BEWARE: Length must equal openmpi package's
  src = "${openmpi_rsg_plugins}"; # We have no source here...

  nativeBuildInputs = [ python rsync ];
  buildInputs = [ openmpi openmpi_rsg_plugins ];
  installPhase = ''
    mkdir -p $TMP/out/lib/openmpi

    # Copy all OpenmMPI files into the build directory
    rsync -a ${openmpi}/* $TMP/out --exclude ompi --exclude orte --exclude opal

    # Hack the hardcoded install path in OpenMPI binaries.
    # This is done in python, for sanity's sake
    export BUILDDIR=$TMP
    export OPENMPI=${openmpi}
    export OUT=$out

    python_cmd=$(cat <<-END
    import glob
    import os
    import sys
    from pathlib import Path
    from stat import *

    builddir_path = os.environ['BUILDDIR']
    openmpi_path = os.environ['OPENMPI']
    out_path = os.environ['OUT']

    if len(openmpi_path) != len(out_path):
        raise Exception("OpenMPI path ({}) and out path ({}) should have equal length".format(
            openmpi_path, out_path))

    files_to_hack = glob.glob(builddir_path + "/out/**", recursive=True)

    for filename in files_to_hack:
        # Only work on files
        if not os.path.isfile(filename):
            continue
        if os.path.islink(filename):
            continue

        # Mark the file as writable if needed
        old_mode = os.stat(filename)[ST_MODE]
        changed_mode = False
        if old_mode & S_IWUSR == 0:
            print("Setting write permission to {}".format(filename))
            changed_mode = True
            os.chmod(filename, old_mode | S_IWUSR)

        print('hack {}: {} -> {}'.format(filename, openmpi_path, out_path))

        # Regular (non-directory, non-links) files
        with open(filename, 'rb+') as f:
            print('File opened!')
            # Just read the content
            content = f.read()

            # Hack the path into the file content
            content = content.replace(openmpi_path.encode('ascii'), out_path.encode('ascii'))

            # Update content
            f.seek(0, 0)
            f.write(content)

        if changed_mode:
            os.chmod(filename, old_mode)
    END
    )
    python -c "$python_cmd"

    # Copy plugins
    rsync -a ${openmpi_rsg_plugins}/lib/* $TMP/out/lib

    # Copy the temporary output directory to the nix store
    rsync -a $TMP/out/* $out
  '';
}
