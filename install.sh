#!/bin/sh

ln -fnrs ./preview.sh "$HOME/.local/bin/preview.sh"
ln -fnrs ./preview-less.sh "$HOME/.local/bin/preview-less.sh"

deps="
  atool
  bat
  chafa
"

for dep in $deps; do
  nix profile add nixpkgs#"$dep"
done
