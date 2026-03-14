#!/bin/sh

name=preview
dir="$(cd "$(dirname "$0")" && pwd)"
echo "export PATH=\"$dir\${PATH:+\":\$PATH\"}\"" >"$POSIX_DIR"/"$name".sh

deps="
  atool
  bat
  chafa
"

for dep in $deps; do
  nix profile add nixpkgs#"$dep"
done
