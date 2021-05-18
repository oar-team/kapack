
----------------------------------------------------------------------------------------------------
## Note: Kapack Nix Expressions is superseded by [NUR-Kapack](https://github.com/oar-team/nur-kapack/)
----------------------------------------------------------------------------------------------------

## Kapack Nix Expressions
### Usage

The `/path/to/kapack` in all the folowing commands can be given using different methods:
- Give directly a tarball: https://github.com/oar-team/kapack/archive/master.tar.gz
- Clone this repository and give the path
- Set you NIX_PATH evironment variable with any of the above: `export NIX_PATH=kapack=/path/to/kapack:$NIX_PATH` and use `'<kapack>'`

List available packages using:
```sh
nix-env -qaP -f /path/to/kapack
```

Install a package using:
```sh
nix-env -f /path/to/kapack -iA packagename
```

Some 'user' environments are available (e.g. evalysEnv).
Enter an environment (either the build env for one of our packages,
or a 'user' environment) using:
```sh
nix-shell /path/to/kapack -A environmentname
```

#### Development

Add your package in a folder at the root and create a nix expression in it,
preferably `default.nix`. Add your package to the root Kapack/default.nix.

The global pinned nixpkgs version can be updated with ./pin.sh, which updates the json
file at the root of the package set. This should be done carefully, as it might break
some user packages.
