#!/bin/sh

name=default
usrp install dep
nix profile add nixpkgs#$name
ln -fnrs . "$XDG_CONFIG_HOME"/$name
ln -fnrs ./env "$POSIX_DIR"/"$name".sh
ln -fnrs ./bin "$HOME"/.local/bin/$name
dir="$(cd "$(dirname "$0")" && pwd)"
printf 'export PATH="%s${PATH:+":$PATH"}"' "$dir" >"$POSIX_DIR"/"$name".sh
