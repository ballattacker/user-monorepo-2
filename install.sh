#!/bin/sh

name=mise
nix profile add nixpkgs#$name
ln -frs . "$XDG_CONFIG_DIR"/$name
ln -frs ./env "$POSIX_DIR"/"$name".sh
