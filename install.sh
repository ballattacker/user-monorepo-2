#!/bin/sh

name=neovim
usrp install dev
mise use --global $name@0.11
ln -fnrs . "$XDG_CONFIG_HOME"/nvim
ln -fnrs ./env "$POSIX_DIR"/nvim.sh

deps="
  unzip
  gcc
"

for dep in $deps; do
  nix profile add nixpkgs#"$dep"
done
