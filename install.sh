#!/bin/sh

name=wsl-clip
dir="$(cd "$(dirname "$0")" && pwd)"
printf '[ -z ${WSLENV+x} ] || export PATH="%s${PATH:+":$PATH"}"' "$dir" >"$POSIX_DIR"/"$name".sh
