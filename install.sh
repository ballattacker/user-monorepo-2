#!/bin/sh

name=preview
dir="$(cd "$(dirname "$0")" && pwd)"
printf 'export PATH="%s${PATH:+":$PATH"}"' "$dir" >"$POSIX_DIR"/"$name".sh

deps="
  atool
  bat
  chafa
	ffmpeg
	poppler-utils
"

for dep in $deps; do
  nix profile add nixpkgs#"$dep"
done
