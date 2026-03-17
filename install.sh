#!/bin/sh

name=dev
usrp install mise
ln -fnrs ./env "$POSIX_DIR"/"$name".sh
ln -fnrs ./python "$XDG_CONFIG_HOME"/python
eval "$("$USRP_DIR"/activate)"

deps="
  bun
  deno
  go
  python
  rust
  zig
"

for dep in $deps; do
  mise use --global "$dep"@latest
done
mise use --global node@24
