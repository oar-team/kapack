## Kapack Nix Expressions

#### Usage

Clone the repository.

List available packages using:
```
nix-env -qaP -f /path/to/kapack
```

Install a package using:
```
nix-env -f /path/to/kapack -iA packagename
```

Temporarily put some packages in your environment using:
```
nix-run -f /path/to/kapack packagename packagename
```

Note that this also exposes packages from the pinned nixpkgs version, if you
should need one of those:
```
nix-run -f /path/to/kapack packagename pinnedPkgs.ghc
```

Some 'user' environments are available (e.g. evalysEnv).
Enter an environment (either the build env for one of our packages,
or a 'user' environment) using:
```
nix-shell /path/to/kapack -A environmentname
```

#### Development

Add your package in a folder at the root and create a nix expression in it,
preferably `default.nix`. Add your package to the root Kapack/default.nix.

The global pinned nixpkgs version can be updated with ./pin.sh, which updates the json
file at the root of the package set. This should be done carefully, as it might break
some user packages.
