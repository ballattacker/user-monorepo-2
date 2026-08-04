#!/bin/sh

name=yazi
usrp install preview
mise use --global $name@26.1
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
