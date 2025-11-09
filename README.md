# My Personal Configuration

This repository contains my personal terminal setup and dotfiles configuration for macOS.

<img width="1972" height="1236" alt="CleanShot 2025-08-14 at 12 16 17" src="https://github.com/user-attachments/assets/27d3462b-2797-4ae8-8232-d2240867b18c" />

## Features

- **Modern Terminal Experience** with Ghostty/Wezterm
- **Tiling Window Management** using yabai + skhd
- **Powerful Neovim Setup** with AstroNvim
- **Tmux Session Management** with custom plugins
- **Beautiful Shell** with Starship prompt and Oh My Zsh
- **Catppuccin Theme** across all tools

## Tools & Applications

### Terminal & Shell
- **[Ghostty](https://ghostty.org/)** / **[Wezterm](https://wezfurlong.org/wezterm/)** – Terminal emulators
- **[Tmux](https://github.com/tmux/tmux)** – Terminal multiplexer with custom plugins
- **[Zsh](https://www.zsh.org/)** – Shell with Oh My Zsh framework
- **[Starship](https://starship.rs/)** – Cross-shell prompt

### Window Management
- **[yabai](https://github.com/koekeishiya/yabai)** – Tiling window manager for macOS
- **[skhd](https://github.com/koekeishiya/skhd)** – Simple hotkey daemon
- **[Aerospace](https://github.com/nikitabobko/AeroSpace)** – Alternative tiling window manager

### Editor & Development
- **[Neovim](https://neovim.io/)** – Hyperextensible Vim-based text editor
- **[AstroNvim](https://github.com/AstroNvim/AstroNvim)** – Neovim configuration framework
- **[Lazydocker](https://github.com/jesseduffield/lazydocker)** – Terminal UI for Docker

### CLI Tools
- **[bat](https://github.com/sharkdp/bat)** – Cat clone with syntax highlighting
- **[eza](https://github.com/eza-community/eza)** – Modern replacement for ls
- **[fzf](https://github.com/junegunn/fzf)** – Fuzzy finder
- **[zoxide](https://github.com/ajeetdsouza/zoxide)** – Smarter cd command
- **[yazi](https://github.com/sxyazi/yazi)** – Terminal file manager

## Prerequisites

Before installation, make sure you have:

```bash
# Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install required tools
brew install stow git
```

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/fiqryq/dot-config.git ~/dot-config
cd ~/dot-config
```

### 2. Run the Setup Script

The repository includes a setup script that handles symlinking:

```bash
# Dry run (preview changes)
./setup.sh --dry-run

# Install dotfiles
./setup.sh

# Restow (refresh symlinks)
./setup.sh --restow

# Unstow (remove symlinks)
./setup.sh --unstow
```

### 3. Install Tmux Plugins

After installation, open tmux and install plugins:

```bash
tmux
# Press prefix + I (capital i) to install plugins
# Default prefix is Ctrl+A
```

### 4. Install Neovim Plugins

Open Neovim and let it install plugins automatically:

```bash
nvim
# Wait for plugins to install
```

## Directory Structure

```
dot-config/
├── aerospace/          # AeroSpace window manager config
├── ghostty/           # Ghostty terminal config
├── nvim/              # Neovim configuration
├── skhd/              # Hotkey daemon config
├── tmux/              # Tmux configuration & scripts
├── wezterm/           # Wezterm terminal config
├── yabai/             # Yabai window manager config
├── yazi/              # Yazi file manager config
├── zsh/               # Zsh shell configuration
├── .gitignore         # Git ignore rules
├── .stowrc            # Stow configuration
└── setup.sh           # Installation script
```

## Post-Installation

### Optional Dependencies

Install additional tools used in the configuration:

```bash
# Shell enhancements
brew install zsh starship zoxide eza bat fzf

# Development tools
brew install neovim tmux lazydocker

# Window management
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd

# File manager
brew install yazi

# Terminal emulator (choose one)
brew install --cask ghostty
# or
brew install --cask wezterm
```

### Environment Variables

Some configurations reference `$HOME/.env.local` for local environment variables. Create this file if needed:

```bash
touch ~/.env.local
# Add your local variables here
```

## Customization

- **Neovim**: Edit files in `nvim/lua/plugins/` to customize plugins
- **Tmux**: Edit `tmux/tmux.conf` for tmux settings
- **Shell**: Edit `zsh/.zshrc` for shell aliases and functions
- **Window Manager**: Edit `yabai/yabairc` and `skhd/skhdrc` for window management

## Updating

To update the dotfiles:

```bash
cd ~/dot-config
git pull
./setup.sh --restow
```

## Troubleshooting

### Stow Conflicts

If you encounter conflicts during installation:

```bash
# The setup script automatically backs up conflicting files
# Check for .backup.<timestamp> files in your home directory
```

### Tmux Plugins Not Working

```bash
# Reinstall TPM (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install plugins: prefix + I in tmux
```

## License

Feel free to use and modify these dotfiles for your own setup.

## Credits

- [AstroNvim](https://github.com/AstroNvim/AstroNvim) for the Neovim configuration framework
- [Catppuccin](https://github.com/catppuccin) for the beautiful color scheme
- Various open-source projects that make this setup possible
