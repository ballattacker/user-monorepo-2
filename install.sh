#!/bin/sh

name=zsh
usrp install yazi
nix profile add nixpkgs#$name
ln -frs . "$XDG_CONFIG_DIR"/$name
ln -frs ./.zshenv "$POSIX_DIR"/$name

nix profile add nixpkgs#fzf
nix profile add nixpkgs#starship
git submodule update --init --recursive
