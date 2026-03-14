#!/bin/sh

name=zellij
usrp install zsh
nix profile add nixpkgs#$name
ln -fnrs . "$XDG_CONFIG_HOME"/$name
