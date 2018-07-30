{ openmpi, fetchgit }:

openmpi.overrideAttrs (oldAttrs: rec {
# name = "openmpi-3.1.1";
  name = "openmpi-3-dev"; # Should have the same length as openmpi's name

  src = fetchgit {
    rev = "f6144385187e4d0decb85e33b6af69205cb8837b";
    url = "https://github.com/open-mpi/ompi.git";
    sha256 = "0gb3k577161rw1kzm85rnqkvi5zxmxcjdvcymh3lzsa7w2mb8mr5";
  };
  }
)
