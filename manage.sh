#!/bin/sh
# manage.sh - Module management for the dotfiles repo
# Orchestrates worktree creation, cloning, and installation

set -eu

repo_dir="$(cd "$(dirname "$0")" && pwd)"
modules_dir="$repo_dir/.worktrees/module"
mkdir -p "$modules_dir"

# Parse global flags
dry_run=false
while [ $# -gt 0 ]; do
  case "$1" in
  --dry-run)
    dry_run=true
    shift
    ;;
  --help | -h)
    cat <<'EOF'
Usage: manage.sh <command> [options] [args]

Commands:
  create <name>              Create a new module branch and worktree
  clone <name> [name ...]    Clone/update modules into worktrees
  install [dir ...]          Install module(s) from given directories
  status                     Show dirty repositories
  pull                       Pull all repositories
  push                       Commit and push all repositories
  list                       List all module branches

Options:
  --dry-run                  Simulate install without executing scripts
  --help, -h                 Show this help message

Examples:
  manage.sh create zsh
  manage.sh clone nvim mise
  manage.sh install .worktrees/module/git .worktrees/module/nvim
  manage.sh install --dry-run .worktrees/module/git
  manage.sh status
EOF
    exit 0
    ;;
  *) break ;;
  esac
done

# Get the command
cmd="${1:-}"
shift || true

case "$cmd" in
create)
  [ -z "${1:-}" ] && echo "Usage: $0 create <module-name>" >&2 && exit 1
  cd "$repo_dir"
  git branch "$1" origin/template 2>/dev/null || {
    echo "error: Failed to create branch: $1" >&2
    exit 1
  }
  git worktree add "$modules_dir/$1" "$1"
  echo "✓ Created module: $1"
  ;;

clone)
  [ -z "${1:-}" ] && echo "Usage: $0 clone <module-name> [module-name ...]" >&2 && exit 1
  cd "$repo_dir"
  while [ -n "${1:-}" ]; do
    dir="$modules_dir/$1"
    if [ -d "$dir" ]; then
      if [ -d "$dir/.git" ] || [ -f "$dir/.git" ]; then
        git pull -C "$dir"
        echo "✓ Updated module: $1"
      else
        echo "error: Directory $dir exists but is not a git repository" >&2
        exit 1
      fi
    else
      git worktree add "$dir" "$1"
      echo "✓ Cloned module: $1"
    fi
    shift
  done
  ;;

install)
  [ -z "${1:-}" ] && echo "Usage: $0 install [--dry-run] <module-dir> [module-dir ...]" >&2 && exit 1

  # Check if first arg is --dry-run
  if [ "$1" = "--dry-run" ]; then
    dry_run=true
    shift
  fi

  [ -z "${1:-}" ] && echo "Usage: $0 install [--dry-run] <module-dir> [module-dir ...]" >&2 && exit 1

  # Process each module
  while [ -n "${1:-}" ]; do
    dir="$(realpath "$1")"
    if [ ! -d "$dir" ]; then
      echo "error: Module directory not found: $dir" >&2
      exit 1
    fi

    if [ ! -f "$dir/install.sh" ]; then
      echo "error: No install.sh found in $dir" >&2
      exit 1
    fi

    module_name="$(basename "$dir")"
    echo "Installing module: $module_name"

    if [ "$dry_run" = true ]; then
      echo "  [DRY RUN] Would execute: sh $dir/install.sh"
      if sh -n "$dir/install.sh"; then
        echo "  ✓ install.sh syntax is valid"
      else
        echo "  ✗ install.sh has syntax errors" >&2
        exit 1
      fi
    else
      if ! sh "$dir/install.sh"; then
        echo "error: Installation failed for module: $module_name" >&2
        exit 1
      fi
      echo "  ✓ Installed successfully"
    fi

    shift
  done
  ;;

status)
  echo "Checking repository status..."
  find "$repo_dir" -name ".git" -type f -o -name ".git" -type d 2>/dev/null | while read -r gitdir; do
    repo_path="$(dirname "$gitdir")"
    if [ -n "$(git -C "$repo_path" status --porcelain 2>/dev/null)" ]; then
      echo "$repo_path (dirty)"
      git -C "$repo_path" status -s -b 2>/dev/null || true
    fi
  done
  ;;

pull)
  echo "Pulling all repositories..."
  find "$repo_dir" -name ".git" -type f -o -name ".git" -type d 2>/dev/null | while read -r gitdir; do
    repo_path="$(dirname "$gitdir")"
    echo "Pulling $repo_path..."
    git -C "$repo_path" pull 2>/dev/null || true
  done
  ;;

push)
  echo "Pushing all repositories..."
  find "$repo_dir" -name ".git" -type f -o -name ".git" -type d 2>/dev/null | while read -r gitdir; do
    repo_path="$(dirname "$gitdir")"
    echo "Pushing $repo_path..."
    git -C "$repo_path" add --all 2>/dev/null || true
    git -C "$repo_path" commit -m "auto: manage.sh push" 2>/dev/null || true
    git -C "$repo_path" push 2>/dev/null || true
  done
  ;;

list)
  echo "Modules:"
  git -C "$repo_dir" branch -a 2>/dev/null | grep -v "^\*" | sed 's/^[[:space:]]*//' || true
  ;;

*)
  if [ -z "$cmd" ]; then
    echo "Usage: $0 <command> [options] [args]" >&2
    echo "Run '$0 --help' for usage information" >&2
    exit 1
  else
    echo "error: Unknown command: $cmd" >&2
    echo "Run '$0 --help' for usage information" >&2
    exit 1
  fi
  ;;
esac
