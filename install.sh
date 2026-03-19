#!/bin/sh

name=yazi
nix profile add nixpkgs#$name
ln -fnrs . "$XDG_CONFIG_HOME"/$name
ln -fnrs ./hook "$POSIX_DIR"/"$name".sh

deps="
	fzf
	zoxide
	fd
	ripgrep
  jq
  chafa
	ffmpeg
  ouch
  resvg
  imagemagick
  poppler-utils
"

for dep in $deps; do
  nix profile add nixpkgs#"$dep"
done
