#!/bin/sh

name=mise
nix profile add nixpkgs#$name
ln -fnrs . "$XDG_CONFIG_HOME"/$name
ln -fnrs ./env "$POSIX_DIR"/"$name".sh
