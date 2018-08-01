{ stdenv, openmpi, openmpi_rsg_plugins, python, rsync }:

stdenv.mkDerivation rec {
# name = "openmpi-3.1.1";
  name = "openmpi-rsg-u"; # BEWARE: Length must equal openmpi package's

  # This package has no source. It's just a mix of OpenMPI + plugins
  phases = [ "buildPhase" "installPhase" ];

  nativeBuildInputs = [ python rsync ];
  buildInputs = [ openmpi openmpi_rsg_plugins ];

  buildPhase = ''
    mkdir -p $TMP/out/lib/openmpi

    echo "Copy OpenMPI files into the build directory"
    rsync -a ${openmpi}/* $TMP/out --exclude ompi --exclude orte --exclude opal

    echo "Hack the hardcoded install path of the OpenMPI binaries"
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
            changed_mode = True
            os.chmod(filename, old_mode | S_IWUSR)

        # print('hack OpenMPI path in {}'.format(filename, openmpi_path,
        #     out_path))

        # Regular (non-directory, non-links) files
        with open(filename, 'rb+') as f:
            # Just read the content
            content = f.read()

            # Hack the path into the file content
            content = content.replace(openmpi_path.encode('ascii'),
                out_path.encode('ascii'))

            # Update content
            f.seek(0, 0)
            f.write(content)

        if changed_mode:
            os.chmod(filename, old_mode)
    END
    )
    python -c "$python_cmd"

    echo "Copy plugins into the build directory"
    rsync -a ${openmpi_rsg_plugins}/lib/* $TMP/out/lib
  '';

  installPhase = ''
    echo "Move the temporary directory into the nix store"
    rsync -a $TMP/out/* $out
  '';
}
