#!/bin/sh

cd "$(dirname "$0")" || exit
name=neovim
usrp install mise
nix profile add nixpkgs#$name
ln -frs . "$XDG_CONFIG_HOME"/nvim
ln -frs ./env "$POSIX_DIR"/nvim.sh

deps="
  unzip
  gcc
"

for dep in $deps; do
  nix profile add nixpkgs#"$dep"
done

deps="
  bun
  deno
  go
  node
  python
  rust
  zig
"

for dep in $deps; do
  mise use --global "$dep"@latest
done
