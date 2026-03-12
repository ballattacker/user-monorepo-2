#!/bin/sh

name=yazi
usrp install preview
nix profile add nixpkgs#$name
ln -fnrs . "$XDG_CONFIG_HOME"/$name
ln -fnrs ./hook "$POSIX_DIR"/"$name".sh

deps="
	fzf
	zoxide
	atool rar unzip zip
	fd
	ripgrep
	ffmpeg
	p7zip
	poppler
"

for dep in $deps; do
  nix profile add nixpkgs#"$dep"
done
