{ pkgs ? import <nixpkgs> {} }:

rec {
    # helper for python mirror url
    first_letter = pname: builtins.head (pkgs.lib.strings.stringToCharacters pname);
    pypi_url = pname: name: "mirror://pypi/${first_letter pname}/${pname}/${name}.tar.gz";
}

