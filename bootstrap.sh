#!/usr/bin/env sh
set -eu

REPO="${1:-}"
if [ -z "$REPO" ]; then
  echo "Usage: sh bootstrap.sh <dotfiles_repo_url>"
  exit 1
fi

OS="$(uname -s)"

install_chezmoi_macos() {
  command -v chezmoi >/dev/null 2>&1 && return 0
  command -v brew >/dev/null 2>&1 || { echo "Homebrew not found. Install from https://brew.sh/ then rerun."; exit 1; }
  brew install chezmoi
}

install_chezmoi_arch() {
  command -v chezmoi >/dev/null 2>&1 && return 0
  command -v pacman >/dev/null 2>&1 || { echo "pacman not found. This script is intended for Arch/CachyOS."; exit 1; }
  sudo pacman -Syu --needed chezmoi
}

case "$OS" in
  Darwin) install_chezmoi_macos ;;
  Linux)  install_chezmoi_arch ;;
  *) echo "Unsupported OS: $OS"; exit 1 ;;
esac

chezmoi init --apply "$REPO"

echo "Done."
echo "Tip: chezmoi cd / chezmoi diff / chezmoi apply"
