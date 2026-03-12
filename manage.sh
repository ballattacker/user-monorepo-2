#!/bin/sh
# manage.sh - Modern module management for dotfiles
# Enhanced worktree creation, cloning, and installation with better error handling

set -eu

# Configuration
repo_dir="$(dirname "$(realpath "$0")")"
modules_dir="$repo_dir/.worktrees/module"
mkdir -p "$modules_dir"

# Utility functions
print_error() {
  printf "\033[31mError:\033[0m %s\n" "$@" >&2
}

print_success() {
  printf "\033[32m✓\033[0m %s\n" "$@"
}

print_info() {
  printf "\033[34m→\033[0m %s\n" "$@"
}

print_warning() {
  printf "\033[33m⚠\033[0m %s\n" "$@" >&2
}

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
  install [dir/name ...]     Install module(s) from given directories/modules
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
  manage.sh install git .worktrees/module/nvim
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

# Main command handler
case "$cmd" in
setup)
  curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh -s -- --daemon
  mkdir -p "$HOME"/.config/nix
  echo "experimental-features = nix-command flakes" >>"$HOME"/.config/nix/nix.conf
  sh -c "nix registry add nixpkgs github:numtide/nixpkgs-unfree/nixos-unstable"

  mkdir -p "$repo_dir/posix.d"
  echo "eval \"\$($repo_dir/activate)\"" >>"${1:-$HOME/.bashrc}"

  mkdir -p "$HOME"/.local/bin
  ln -frs "$repo_dir"/manage.sh "$HOME"/.local/bin/usrp
  exec $SHELL
  ;;

create)
  if [ -z "${1:-}" ]; then
    print_error "Usage: $0 create <module-name>"
    exit 1
  fi

  module_name="$1"
  cd "$repo_dir"

  if git rev-parse --verify "$module_name" 2>/dev/null; then
    print_warning "Branch '$module_name' already exists"
  else
    print_info "Creating branch '$module_name' from template..."
    if ! git branch module/"$module_name" origin/template --no-track 2>/dev/null; then
      print_error "Failed to create branch: $module_name"
      exit 1
    fi
  fi

  if [ -d "$modules_dir/$module_name" ]; then
    print_warning "Worktree directory already exists"
  else
    print_info "Creating worktree for '$module_name'..."
    git worktree add "$modules_dir/$module_name" "$module_name"
  fi

  print_success "Created module: $module_name"
  ;;

clone)
  if [ -z "${1:-}" ]; then
    print_error "Usage: $0 clone <module-name> [module-name ...]"
    exit 1
  fi

  cd "$repo_dir"

  while [ -n "${1:-}" ]; do
    module_name="$1"
    module_path="$modules_dir/$module_name"

    if [ -d "$module_path" ]; then
      if [ -d "$module_path/.git" ] || [ -f "$module_path/.git" ]; then
        print_info "Updating module: $module_name"
        if git -C "$module_path" pull; then
          print_success "Updated module: $module_name"
        else
          print_warning "Update failed for: $module_name"
        fi
      else
        print_error "Directory '$module_path' exists but is not a git repository"
        exit 1
      fi
    else
      print_info "Cloning module: $module_name"
      if git worktree add "$module_path" module/"$module_name"; then
        print_success "Cloned module: $module_name"
      else
        print_error "Failed to clone module: $module_name"
        exit 1
      fi
    fi

    shift
  done
  ;;

install)
  if [ -z "${1:-}" ]; then
    print_error "Usage: $0 install [--dry-run] <module-dir> [module-dir ...]"
    exit 1
  fi

  # Check if first arg is --dry-run
  if [ "$1" = "--dry-run" ]; then
    dry_run=true
    shift
  fi

  if [ -z "${1:-}" ]; then
    print_error "Usage: $0 install [--dry-run] <module-dir> [module-dir ...]"
    exit 1
  fi

  owd="$(pwd)"
  while [ -n "${1:-}" ]; do
    cd "$owd" || exit

    if [ ! -d "$1" ]; then
      module_name=$1
      $0 clone "$module_name"
      dir="$modules_dir/$module_name"
    else
      dir="$(cd "$1" && pwd)"
    fi

    if [ ! -d "$dir" ]; then
      print_error "Module directory not found: $dir"
      exit 1
    fi

    if [ ! -f "$dir/install.sh" ]; then
      print_error "No install.sh found in $dir"
      exit 1
    fi

    module_name="$(basename "$dir")"
    print_info "Installing module: $module_name"

    cd "$dir" || exit

    if [ "$dry_run" = true ]; then
      print_info "  [DRY RUN] Would execute: sh install.sh"

      if sh -n install.sh 2>/dev/null; then
        print_success "  ✓ install.sh syntax is valid"
      else
        print_error "  ✗ install.sh has syntax errors"
        exit 1
      fi
    else
      print_info "  Executing install.sh..."

      if sh install.sh; then
        print_success "  ✓ Installed successfully"
      else
        print_error "  ✗ Installation failed for module: $module_name"
        exit 1
      fi
    fi

    shift
  done
  ;;

status)
  print_info "Checking repository status..."

  # Find all git repositories including worktrees
  find "$repo_dir" -name ".git" -type f -o -name ".git" -type d 2>/dev/null | while read -r gitdir; do
    repo_path="$(dirname "$gitdir")"

    # Check if there are any changes
    if git -C "$repo_path" status --porcelain 2>/dev/null | grep -q .; then
      print_info "$repo_path (dirty)"
      git -C "$repo_path" status -s -b 2>/dev/null || true
    fi
  done
  ;;

pull)
  print_info "Pulling all repositories..."

  find "$repo_dir" -name ".git" -type f -o -name ".git" -type d 2>/dev/null | while read -r gitdir; do
    repo_path="$(dirname "$gitdir")"
    print_info "Pulling $repo_path..."

    if git -C "$repo_path" pull 2>/dev/null; then
      print_success "✓ Pulled $repo_path"
    else
      print_warning "✗ Failed to pull $repo_path"
    fi
  done
  ;;

push)
  print_info "Pushing all repositories..."

  find "$repo_dir" -name ".git" -type f -o -name ".git" -type d 2>/dev/null | while read -r gitdir; do
    repo_path="$(dirname "$gitdir")"
    print_info "Pushing $repo_path..."

    # Stage all changes
    git -C "$repo_path" add --all 2>/dev/null || true

    # Commit if there are changes
    if git -C "$repo_path" diff --cached --quiet; then
      print_info "  No changes to commit"
    else
      git -C "$repo_path" commit -m "auto: manage.sh push" 2>/dev/null || true
    fi

    # Push changes
    if git -C "$repo_path" push 2>/dev/null; then
      print_success "✓ Pushed $repo_path"
    else
      print_warning "✗ Failed to push $repo_path"
    fi
  done
  ;;

list)
  print_info "Modules:"

  # List all module branches
  if git -C "$repo_dir" branch -r --list 'origin/module/*' | sed 's|  origin/module/||'; then
    true
  else
    print_info "No modules found"
  fi
  ;;

*)
  if [ -z "$cmd" ]; then
    print_error "Usage: $0 <command> [options] [args]"
    print_error "Run '$0 --help' for usage information"
    exit 1
  else
    print_error "Unknown command: $cmd"
    print_error "Run '$0 --help' for usage information"
    exit 1
  fi
  ;;
esac
