#!/bin/sh

name=default
usrp install dep
nix profile add nixpkgs#$name
ln -fnrs . "$XDG_CONFIG_HOME"/$name
ln -fnrs ./env "$POSIX_DIR"/"$name".sh
ln -fnrs ./bin "$HOME"/.local/bin/$name
dir="$(cd "$(dirname "$0")" && pwd)"
echo "export PATH=\"$dir\${PATH:+\":\$PATH\"}\"" >"$POSIX_DIR"/"$name".sh
