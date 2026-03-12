#!/bin/sh

name=zsh
usrp install yazi
nix profile add nixpkgs#$name
ln -fnrs . "$XDG_CONFIG_HOME"/$name
ln -fnrs ./.zshenv "$POSIX_DIR"/"$name".sh

nix profile add nixpkgs#fzf
nix profile add nixpkgs#starship
git submodule update --init --recursive
