# dotfiles_plus_v7

My Dot Files for Arch and Mac

## Overview

This repository contains my personal dotfiles managed with [chezmoi](https://www.chezmoi.io/). It supports both macOS (Darwin) and Arch Linux, automatically installing packages, applying system defaults, and configuring your development environment.

**Features:**
- 🚀 One-command bootstrap for fresh machines
- 📦 Automatic package installation (Homebrew on macOS, pacman/AUR on Arch)
- ⚙️ Developer-friendly macOS defaults
- 🔧 Service management (skhd, sketchybar, window managers)
- 🎨 Pre-configured terminal, editor, and shell setups

## Prerequisites

### macOS
- [Homebrew](https://brew.sh/) installed (the bootstrap script will check for this)

### Arch Linux
- `pacman` package manager
- An AUR helper (paru or yay) - will be installed automatically if not present

## Quick Start

### Initial Setup

1. Clone this repository (or use the bootstrap script directly):
   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/christianmorton/dotfiles/main/bootstrap.sh)" -- https://github.com/christianmorton/dotfiles
   ```

   Or if you've already cloned it:
   ```bash
   cd dotfiles-main
   sh bootstrap.sh https://github.com/christianmorton/dotfiles
   ```

2. The bootstrap script will:
   - Install `chezmoi` (via Homebrew on macOS or pacman on Arch)
   - Initialize and apply the dotfiles
   - Run all setup scripts automatically

3. **After Installation** - Complete the post-installation steps (see "After Installation" section below)

### What Gets Installed

#### macOS (via Homebrew)

**Base Packages** (`Brewfile`):
- **Terminal & Shell**: kitty, tmux, starship, zsh, zoxide
- **Editors**: neovim, VS Code, Cursor
- **Core Tools**: git, ripgrep, fd, fzf, bat, jq, lazygit, glow
- **Languages**: node, typescript, python, go, rust
- **Utilities**: direnv, gh, tree, htop, google-cloud-sdk
- **Window Manager**: Aerospace
- **Keyboard**: Karabiner Elements
- **Apps**: Alfred, Docker Desktop
- **Fonts**: JetBrains Mono Nerd Font, Hack Nerd Font

**Extra Packages** (`Brewfile.extra` - customizable):
- GitHub Desktop, Discord, Arc Browser, Google Chrome
- NordVPN, Notion, Linear, ChatGPT, Spotify
- Cyberduck (FTP/SFTP client)
- Monarch (productivity launcher)
- Additional dev tools (see `Brewfile.extra` for full list)

**System Configuration**:
- Developer-friendly macOS defaults (key repeat, Finder, Dock, etc.)
- Service management for skhd, sketchybar, window managers
- nvm (Node Version Manager) with Node.js 20 installed
- n (alternative Node.js version manager) with Node.js 20 installed
- Google Cloud SDK (gcloud CLI) for GCP management
- Firebase CLI (firebase-tools) for Firebase project management

#### Arch Linux (via pacman & AUR)
- Packages listed in `packages/arch-pacman.txt`
- AUR packages listed in `packages/arch-aur.txt`
- Additional setup for keyd (keyboard remapping)

## After Installation

After running `chezmoi apply` or the bootstrap script, follow these steps:

### 1. Restart Your Terminal
Close and reopen your terminal (or run `source ~/.zshrc`) to load:
- nvm/n environment variables
- oh-my-zsh configuration
- Updated PATH variables

### 2. Verify Installations

Check that everything installed correctly:

```bash
# Node.js version managers
nvm --version          # Should show nvm version
n --version            # Should show n version
node --version         # Should show v20.x.x

# Development tools
firebase --version     # Should show Firebase CLI version
gcloud --version       # Should show Google Cloud SDK version
git --version          # Should show git version
nvim --version         # Should show Neovim version

# Package managers
brew --version         # Should show Homebrew version
```

### 3. Initialize Tools (if needed)

Some tools require initial setup:

**Google Cloud SDK:**
```bash
gcloud init                    # Initialize gcloud (first time only)
gcloud auth login              # Authenticate with Google account
```

**Firebase CLI:**
```bash
firebase login                 # Authenticate with Firebase account
```

**Git (if not already configured):**
```bash
git config --global user.name "Christian Morton"
git config --global user.email "christian.morton@claimsgate.co.uk"
```

### 4. Complete macOS Permissions Setup

See the [macOS Setup Checklist](#macos-setup-checklist) section below for:
- Accessibility permissions
- Secure Keyboard Entry settings
- SketchyBar configuration
- Window manager setup
- Karabiner Elements configuration

### 5. Verify Services Are Running

Check that background services started:

```bash
# Check Homebrew services
brew services list

# Services should show as "started":
# - skhd (if installed)
# - sketchybar (if installed)
```

If services aren't running, start them manually:
```bash
brew services start skhd
brew services start sketchybar
```

### 6. Test Your Configuration

Try opening a few applications to verify everything works:
- Open **Kitty** terminal - should use midnight theme
- Open **VS Code** or **Cursor** - should use midnight theme
- Open **tmux** - should show midnight theme status bar
- Check **SketchyBar** in menu bar (if installed)

### 7. Optional: Install Additional Node.js Packages

If you need additional global npm packages:
```bash
npm install -g <package-name>
```

### 8. Log Out/In (Recommended)

After completing all setup steps, **log out and log back in** (or reboot) to ensure:
- All system permissions are active
- macOS defaults are fully applied
- Services are properly initialized

## Usage

### Basic Chezmoi Commands

After setup, you can manage your dotfiles with chezmoi:

```bash
# View changes before applying
chezmoi diff

# Apply changes from the repository
chezmoi apply

# Edit a dotfile (chezmoi will track changes)
chezmoi edit ~/.tmux.conf

# Navigate to the source directory
chezmoi cd

# See what files are managed
chezmoi managed

# See what would change
chezmoi diff
```

### Updating Dotfiles

1. Make changes in the repository (or use `chezmoi edit`)
2. Commit and push to your repository
3. On other machines, pull and apply:
   ```bash
   chezmoi update
   chezmoi apply
   ```

### Adding New Dotfiles

```bash
# Add a new file to be managed
chezmoi add ~/.myconfig

# The file will be copied to the source directory
# Edit it with: chezmoi edit ~/.myconfig
```

## What's Configured

### Applications
- **Neovim**: Lua-based configuration (`dot_config/nvim/init.lua`)
- **tmux**: Enhanced vim-like navigation, mouse support, custom keybinds, status bar styling (`dot_tmux.conf`)
- **Kitty**: Terminal configuration with font and keybindings (`dot_config/kitty/kitty.conf`)
- **Karabiner Elements** (macOS): Caps lock remapping (`dot_config/karabiner/`)
- **Aerospace** (macOS): Window manager config (`dot_config/aerospace/`)
- **Hyprland** (Linux): Window manager config (`dot_config/hypr/`)

### macOS System Defaults
The setup automatically applies developer-friendly macOS preferences:
- **Keyboard**: Fast key repeat, disable smart quotes/dashes/capitalization
- **Finder**: Show hidden files, path bar, status bar, list view by default
- **Dock**: Autohide, no delay, minimize to app icon
- **Screenshots**: Save to `~/Screenshots`, PNG format, no shadow
- **Security**: Require password immediately after sleep
- **File System**: Don't create .DS_Store on network/USB volumes

### Convenience Features
- A symlink `~/.dotfiles` → chezmoi source directory for easy access
- Automatic package installation on first run (base + extra)
- OS-specific setup scripts that run once
- Service management for background tools

## Customization

### Adding Packages

- **macOS Base**: Edit `Brewfile` for core packages
- **macOS Personal**: Edit `Brewfile.extra` for your personal apps/tools
- **Arch**: Edit `packages/arch-pacman.txt` or `packages/arch-aur.txt`

After editing, run:
```bash
chezmoi apply
```

Or manually:
```bash
brew bundle --file Brewfile
brew bundle --file Brewfile.extra
```

### Modifying Configs

Use `chezmoi edit` to modify any managed file:
```bash
chezmoi edit ~/.tmux.conf
chezmoi edit ~/.config/nvim/init.lua
```

### Run-Once Scripts

The `run_once_*.sh.tmpl` scripts execute automatically on first `chezmoi apply`. They handle:
- `run_once_05-dotfiles-symlink.sh.tmpl`: Creates `~/.dotfiles` symlink
- `run_once_10-packages-darwin.sh.tmpl`: Installs Homebrew packages (base + extra)
- `run_once_14-nvm.sh.tmpl`: Installs nvm and Node.js 20
- `run_once_15-aur-arch.sh.tmpl`: Installs AUR packages (Arch only)
- `run_once_16-n.sh.tmpl`: Installs n and Node.js 20 (alternative Node.js version manager)
- `run_once_17-firebase-tools.sh.tmpl`: Installs firebase-tools globally via npm
- `run_once_25-macos-defaults.sh.tmpl`: Applies macOS system defaults
- `run_once_30-macos-karabiner-note.sh.tmpl`: Prints Karabiner setup instructions
- `run_once_35-cursor-settings.sh.tmpl`: Links Cursor editor settings
- `run_once_36-vscode-settings.sh.tmpl`: Links VS Code settings
- `run_once_40-services-darwin.sh.tmpl`: Starts services (skhd, sketchybar, etc.)

To re-run a script, remove its marker file in `~/.local/share/chezmoi/run_once/` or use `chezmoi apply --force`.

## Tips

- Use `chezmoi cd` to quickly navigate to the source directory
- Check `chezmoi diff` before applying to see what will change
- The `~/.dotfiles` symlink provides quick access to your dotfiles
- All run_once scripts are idempotent - safe to run multiple times

## macOS Setup Checklist

After running the bootstrap, complete these manual steps:

### 1. Accessibility Permissions
System Settings → **Privacy & Security** → **Accessibility**
- Enable for: `skhd`, `amethyst`, `aerospace` (if installed)
- Enable for your terminal app (Kitty/Terminal/iTerm) if prompted

### 2. Secure Keyboard Entry
Disable "Secure Keyboard Entry" in your terminal app (required for `skhd` to work)

### 3. SketchyBar Setup (if installed)
System Settings → **Desktop & Dock** → **Displays have separate Spaces** = **ON**

### 4. Window Manager Configuration
- **Amethyst**: Open menu bar icon → Preferences → Configure shortcuts
- **Aerospace**: Open menu bar icon → Preferences → Configure layout

### 5. Karabiner Elements (if installed)
1. Open Karabiner-Elements and grant Accessibility + Input Monitoring permissions
2. Karabiner → Complex Modifications → Add rule
3. Enable: "Caps Lock: tap Escape, hold left_command"

After completing these steps, **log out/in (or reboot)** for changes to take effect.

## Troubleshooting

### Chezmoi not found
The bootstrap script should install it automatically. If not:
- **macOS**: `brew install chezmoi`
- **Arch**: `sudo pacman -S chezmoi`

### Packages not installing
- **macOS**: Ensure Homebrew is installed and up to date (`brew update`)
- **Arch**: Ensure you have an AUR helper (paru/yay) installed

### Services not starting
- Check that permissions are granted (see macOS Setup Checklist above)
- Manually start services: `brew services start skhd`

### Configs not applying
Run `chezmoi apply` manually to see any errors:
```bash
chezmoi apply -v
```

### macOS defaults not applying
Some defaults require logout/restart. If a setting doesn't stick:
1. Check System Settings manually
2. Re-run: `chezmoi apply --force` (will re-run all scripts)

## License

Personal dotfiles - use at your own risk!
