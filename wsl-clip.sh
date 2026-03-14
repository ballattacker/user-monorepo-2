#!/bin/bash

# Detect PowerShell backend
if command -v pwsh.exe >/dev/null 2>&1; then
  pwsh="pwsh.exe"
elif command -v powershell.exe >/dev/null 2>&1; then
  pwsh="powershell.exe"
else
  exit 1
fi

pwsh_cmd="$pwsh -NoProfile -NoLogo -NonInteractive -Command"

# Helper functions for the actual work
do_copy() {
  iconv -t utf-16le | clip.exe
}

do_paste() {
  $pwsh_cmd "Get-Clipboard" | sed 's/\r$//' | sed '$ s/\n$//'
}

# Determine action based on the filename used to call the script ($0)
case "$(basename "$0")" in
wl-copy)
  do_copy
  ;;
wl-paste)
  do_paste
  ;;
xclip | xsel)
  # Check arguments for xclip/xsel flags
  for arg in "$@"; do
    case "$arg" in
    -i | -in | --input)
      do_copy
      return
      ;;
    -o | -out | --output)
      do_paste
      return
      ;;
    esac
  done
  ;;
*)
  # Default fallback for direct execution (wsl-clip -i / -o)
  case "$1" in
  -i | -in | --input) do_copy ;;
  -o | -out | --output) do_paste ;;
  *)
    echo "Usage: $0 [-i|-o]"
    exit 1
    ;;
  esac
  ;;
esac
