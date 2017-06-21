## Datamove Nix Expressions

#### Usage

Clone the repository.

List available packages using:
```
nix-env -qaP -f /path/to/datamove-nix
```

Install a package using:
```
nix-env -f /path/to/datamove-nix -iA packagename
```

Some 'user' environments are available (e.g. evalysEnv).
Enter an environment (either the build env for one of our packages,
or a 'user' environment) using:
```
nix-shell /path/to/datamove-nix -A environmentname
```

#### Development

Add your package in a folder at the root and create a nix expression in it,
preferably `default.nix`. Add your package to the root datamove-nix/default.nix.

#
