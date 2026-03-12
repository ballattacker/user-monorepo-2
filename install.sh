#!/bin/sh

name=zellij
nix profile add nixpkgs#$name
ln -frs . "$XDG_CONFIG_DIR"/$name
