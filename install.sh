#!/bin/sh

dir="$(cd "$(dirname "$0")" && pwd)"
export PATH="$dir${PATH:+":$PATH"}"

deps="
  atool
  bat
  chafa
"

for dep in $deps; do
  nix profile add nixpkgs#"$dep"
done
