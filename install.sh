#!/bin/sh

name=nix
nix profile add nixpkgs#nix-search-cli
nix profile add nixpkgs#nix-index
