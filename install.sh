#!/bin/sh

name=default
usrp install dep
nix profile add nixpkgs#$name
ln -frs . "$XDG_CONFIG_DIR"/$name
ln -frs ./env "$POSIX_DIR"/$name
