#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${DOTFILES_DIR:-$HOME/dot-config}"
ZSH_PKG="${ZSH_PKG:-zsh}"

# Zshrc
if [[ ! -d "$REPO_DIR/$ZSH_PKG" && -d "$REPO_DIR/.zshrc" ]]; then
  ZSH_PKG=".zshrc"
fi

# Args
MODE="install" # install | restow | unstow | dry-run
if [[ $# -gt 0 ]]; then
  case "$1" in
  --dry-run | -n) MODE="dry-run" ;;
  --restow | -R) MODE="restow" ;;
  --unstow | -D) MODE="unstow" ;;
  *)
    echo "Unknown option: $1"
    exit 1
    ;;
  esac
fi

# Helpers
need() { command -v "$1" >/dev/null 2>&1 || {
  echo "Missing: $1"
  exit 1
}; }

backup_if_conflict() {
  local path="$1"
  if [[ -e "$path" && ! -L "$path" ]]; then
    local ts
    ts="$(date +%Y%m%d-%H%M%S)"
    local bak="${path}.backup.${ts}"
    echo "Backing up existing file: $path -> $bak"
    mv "$path" "$bak"
  fi
}

# Checks
need stow
[[ -d "$REPO_DIR" ]] || {
  echo "Repo not found: $REPO_DIR"
  exit 1
}
cd "$REPO_DIR"

# Ensure ~/.config exists for the default .stowrc target
mkdir -p "$HOME/.config"

# Actions
case "$MODE" in
dry-run)
  echo "== DRY RUN =="
  echo "Configs -> ~/.config"
  stow -nv .
  echo
  echo "zsh -> ~ (package: $ZSH_PKG)"
  stow -nv -t "$HOME" "$ZSH_PKG"
  ;;
restow)
  echo "== RESTOW =="
  stow -Rv .
  stow -Rv -t "$HOME" "$ZSH_PKG"
  ;;
unstow)
  echo "== UNSTOW =="
  stow -Dv .
  stow -Dv -t "$HOME" "$ZSH_PKG"
  ;;
install)
  echo "== INSTALL =="
  # Protect a real ~/.zshrc before linking
  backup_if_conflict "$HOME/.zshrc"

  # Main configs (use your .stowrc which targets ~/.config)
  echo "Stowing packages to ~/.config ..."
  stow -v .

  # zsh separately to ~
  echo "Stowing '$ZSH_PKG' to ~ ..."
  stow -v -t "$HOME" "$ZSH_PKG"

  echo "✅ Done."
  ;;
esac
