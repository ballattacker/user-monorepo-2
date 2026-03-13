#!/bin/sh

name=dev
usrp install mise
eval "$("$POSIX_DIR"/../activate)"
nix profile add nixpkgs#$name
ln -fnrs ./env "$POSIX_DIR"/"$name".sh
ln -fnrs ./python "$XDG_CONFIG_HOME"/python

deps="
  bun
  deno
  go
  python
  rust
  zig
"

for dep in $deps; do
  mise use --global "$dep"@latest
done
mise use --global node@24
