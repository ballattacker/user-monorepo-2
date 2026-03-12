#!/bin/sh

ln -fns ./preview.sh "$HOME/.local/bin/preview.sh"
ln -fns ./preview-less.sh "$HOME/.local/bin/preview-less.sh"

chmod +x "$HOME/.local/bin/preview.sh"
chmod +x "$HOME/.local/bin/preview-less.sh"
