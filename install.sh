#!/bin/sh

name=zellij
nix profile add nixpkgs#$name
ln -fnrs . "$XDG_CONFIG_HOME"/$name
