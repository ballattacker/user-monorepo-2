#!/bin/sh

name=wsl-xclip
nix profile add nixpkgs#xclip
ln -fnrs ./xclip "$HOME"/.local/bin/xclip
# dir="$(cd "$(dirname "$0")" && pwd)"
# printf 'export PATH="%s${PATH:+":$PATH"}"' "$dir" >"$POSIX_DIR"/"$name".sh
