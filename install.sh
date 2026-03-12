#!/bin/sh

cd "$(dirname "$0")" || exit
name=default
usrp install dep
nix profile add nixpkgs#$name
ln -frs . "$XDG_CONFIG_DIR"/$name
ln -frs ./env "$POSIX_DIR"/"$name".sh
ln -frs ./bin "$HOME"/.local/bin/$name
